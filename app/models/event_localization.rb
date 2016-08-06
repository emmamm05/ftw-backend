class EventLocalization < ActiveRecord::Base

  belongs_to :wristband


  private

    # http://www.telecom.ulg.ac.be/publi/publications/pierlot/Pierlot2011ANewThreeObject/index.html
    def get_coords_in_grid_with_angles ( ref1,ref2,ref3, d1,d2,d3 )

      s =  1

      # first point
      x_0 = initial_coords ( ref1,ref2,ref3 )
      c_0 = get_error_step( ref1,ref2,ref3,x_0,d1,d2,d3  )

      # first possible directions to step ahead.
      x_1_a = { x: x_0[:x] - s , y: x_0[:x] - s }
      x_1_b = { x: x_0[:x] - s , y: x_0[:x] + s }
      x_1_c = { x: x_0[:x] + s , y: x_0[:x] - s }
      x_1_d = { x: x_0[:x] + s , y: x_0[:x] + s }

      # calculate costs of each step
      c_x_1 = []
      c_x_1 << get_error_step( ref1,ref2,ref3,x_1_a, d1,d2,d3  )
      c_x_1 << get_error_step( ref1,ref2,ref3,x_1_b, d1,d2,d3  )
      c_x_1 << get_error_step( ref1,ref2,ref3,x_1_c, d1,d2,d3  )
      c_x_1 << get_error_step( ref1,ref2,ref3,x_1_d, d1,d2,d3  )

      # calculate minimum cost
      min_c = c_x_1.min
      index_min_c =  c_x_1.find_index min_c

      # calculate step direction
      c_x = (index_min_c == 0 || index_min_c == 1) ? -s : s
      c_y = (index_min_c == 0 || index_min_c == 2) ? -s : s

      # iterations
      target_point = x_0
      target_point_cost = c_0
      for iteration in 0..100 do
        new_target_point = { x:target_point.x + c_x, y:target_point.y + c_y }
        new_target_point_cost = get_error_step( ref1,ref2,ref3,new_target_point, d1,d2,d3  )

        # if we reached a minimum, stop iterating
        if new_target_point_cost >= target_point_cost
          break
        end
        target_point = new_target_point
        target_point_cost = new_target_point_cost
      end

      return target_point
    end

    def initial_coords ( ref1,ref2,ref3 )
      center = {}
      center[:x] = ref1.x + ref2.x + ref3.x / 3
      center[:y] = ref1.y + ref2.y + ref3.y / 3
      return center
    end

    def derivate_error_step_x( ref1,ref2,ref3, point, d1,d2,d3 )
      return 2*distance_points_squared( ref1, point, d1 )*2*(ref1.x-d1) + \
        2*distance_points_squared( ref2, point, d2 )*2*(ref2.x-d2) + \
        2*distance_points_squared( ref3, point, d3 )*2*(ref3.x-d3)
    end


    def derivate_error_step_y( ref1,ref2,ref3, point, d1,d2,d3 )
      return 2*distance_points_squared( ref1, point, d1 )*2*(ref1.y-d1) + \
        2*distance_points_squared( ref2, point, d2 )*2*(ref2.y-d2) + \
        2*distance_points_squared( ref3, point, d3 )*2*(ref3.y-d3)
    end

    def get_error_step( ref1,ref2,ref3, point, d1,d2,d3 )
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
