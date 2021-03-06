class EventLocalization < ActiveRecord::Base

  belongs_to :wristband

  def calculate_indoor_coordinates

    # FIXME: calibration
    self.real_distance_a = self.distance_point_a #10 ** self.distance_point_a
    self.real_distance_b = self.distance_point_b #10 ** self.distance_point_b
    self.real_distance_c = self.distance_point_c #10 ** self.distance_point_c

    point = get_coords_in_grid_with_angles(
                                   EventLocalization.reference_nodes[0],
                                   EventLocalization.reference_nodes[1],
                                   EventLocalization.reference_nodes[2],
                                   real_distance_a,
                                   real_distance_b,
                                   real_distance_c)
    self.coord_x = point[:x]
    self.coord_y = point[:y]
  end

  def self.reference_nodes
    #return [ {x:0,y:0}, {x:10.44,y:0}, {x:6.67,y:2.9} ]
    return [ {x:0,y:0}, {x:6.96,y:0}, {x:8.12,y:4.93} ]
  end

  private

    # http://www.telecom.ulg.ac.be/publi/publications/pierlot/Pierlot2011ANewThreeObject/index.html
    def get_coords_in_grid_with_angles ( ref1,ref2,ref3, d1,d2,d3 )

      s =  1

      # first point
      p_0 = { x: ((ref1[:x] + ref2[:x] + ref3[:x]) / 3), y:((ref1[:y] + ref2[:y] + ref3[:y]) / 3) }
      c_0 = cost_function(ref1, ref2, ref3, p_0, d1, d2, d3  )

      # first possible directions to step ahead.
      p_1_a = { x: p_0[:x] - s , y: p_0[:x] - s }
      p_1_b = { x: p_0[:x] - s , y: p_0[:x] + s }
      p_1_c = { x: p_0[:x] + s , y: p_0[:x] - s }
      p_1_d = { x: p_0[:x] + s , y: p_0[:x] + s }

      # calculate costs of each step
      c_p_1 = []
      c_p_1 << cost_function(ref1, ref2, ref3, p_1_a, d1, d2, d3  )
      c_p_1 << cost_function(ref1, ref2, ref3, p_1_b, d1, d2, d3  )
      c_p_1 << cost_function(ref1, ref2, ref3, p_1_c, d1, d2, d3  )
      c_p_1 << cost_function(ref1, ref2, ref3, p_1_d, d1, d2, d3  )

      # calculate minimum cost
      min_c = c_p_1.min
      index_min_c =  c_p_1.find_index min_c

      # calculate step direction
      c_x = (index_min_c == 0 || index_min_c == 1) ? -s : s
      c_y = (index_min_c == 0 || index_min_c == 2) ? -s : s

      # iterations
      target_point = p_0
      target_point_cost = c_0

      for iteration in 0..1000 do

        dx = derivate_error_step_x(ref1, ref2, ref3, target_point, d1, d2, d3)
        dy = derivate_error_step_y(ref1, ref2, ref3, target_point, d1, d2, d3)

        diff = {
            dx: s * dx/Math.sqrt(dx**2 + dy**2),
            dy: s * dy/Math.sqrt(dx**2 + dy**2)
        }

        logger.info "point:#{target_point} cost:#{target_point_cost} #{iteration} #{diff}"

        new_target_point = { x:target_point[:x] + diff[:dx], y:target_point[:y] + diff[:dy] }
        new_target_point_cost = cost_function(ref1, ref2, ref3, new_target_point, d1, d2, d3  )

        # if we reached a minimum, stop iterating
        if new_target_point_cost >= target_point_cost
          logger.info "stopped at point:#{new_target_point} cost:#{new_target_point_cost} #{iteration} #{diff}"
          break
        end

        target_point = new_target_point
        target_point_cost = new_target_point_cost

      end

      return target_point
    end

    def derivate_error_step_x( ref1,ref2,ref3, point, d1,d2,d3 )
      return 2*distance_points_squared( ref1, point, d1 )*2*(ref1[:x]-d1) + \
        2*distance_points_squared( ref2, point, d2 )*2*(ref2[:x]-d2) + \
        2*distance_points_squared( ref3, point, d3 )*2*(ref3[:x]-d3)
    end


    def derivate_error_step_y( ref1,ref2,ref3, point, d1,d2,d3 )
      return 2*distance_points_squared( ref1, point, d1 )*2*(ref1[:y]-d1) + \
        2*distance_points_squared( ref2, point, d2 )*2*(ref2[:y]-d2) + \
        2*distance_points_squared( ref3, point, d3 )*2*(ref3[:y]-d3)
    end

    def cost_function(ref1, ref2, ref3, point, d1, d2, d3 )
      return distance_points_squared( ref1, point, d1 )**2 \
        + distance_points_squared( ref2, point, d2 )**2 \
        + distance_points_squared( ref3, point, d3 )**2
    end

    def distance_points_squared( ref, point, d )
      return ( ref[:x] - point[:x] )**2 +  ( ref[:y] - point[:y] )**2  - d ** 2
    end

   def distance_points( ref, point, d )
     return ( ref[:x] - point[:x] ) +  ( ref[:y] - point[:y] ) - d
   end

end
