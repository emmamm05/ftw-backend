class EventLocalization < ActiveRecord::Base

  belongs_to :wristband

  @reference_nodes = [ {x:100,y:0}, {x:50,y:50}, {x:100,y:100} ]

  def calculate_indoor_coordinates

    real_distance_a = 10 ** self.distance_point_a
    real_distance_b = 10 ** self.distance_point_b
    real_distance_c = 10 ** self.distance_point_c

    get_coords_in_grid_with_angles(@reference_nodes[0],
                                   @reference_nodes[1],
                                   @reference_nodes[2],
                                   real_distance_a,
                                   real_distance_b,
                                   real_distance_c)
  end

  private

    # http://www.telecom.ulg.ac.be/publi/publications/pierlot/Pierlot2011ANewThreeObject/index.html
    def get_coords_in_grid_with_angles ( ref1,ref2,ref3, d1,d2,d3 )

      s =  1

      # first point
      p_0 = { x: (ref1[:x] + ref2[:x] + ref3[:x]) / 3, y:(ref1[:y] + ref2[:y] + ref3[:y] / 3) }
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

        puts "point:#{target_point} cost:#{target_point_cost} #{iteration} #{diff}"

        new_target_point = { x:target_point[:x] + diff[:dx], y:target_point[:y] + diff[:dy] }
        new_target_point_cost = cost_function(ref1, ref2, ref3, new_target_point, d1, d2, d3  )

        # if we reached a minimum, stop iterating
        if new_target_point_cost >= target_point_cost
          puts "stopped at point:#{new_target_point} cost:#{new_target_point_cost} #{iteration} #{diff}"
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
