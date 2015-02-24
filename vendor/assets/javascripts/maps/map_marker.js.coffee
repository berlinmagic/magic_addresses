# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

if google?
  # Orange-Marker:
  orange_marker_image = new google.maps.MarkerImage(
  	'/assets/marker/image.png',
  	new google.maps.Size(26,32),
  	new google.maps.Point(0,0),
  	new google.maps.Point(13,32)
  )

  orange_marker_shadow = new google.maps.MarkerImage(
  	'/assets/marker/shadow.png',
  	new google.maps.Size(46,32),
  	new google.maps.Point(0,0),
  	new google.maps.Point(13,32)
  )

orange_marker_shape =
	coord: [14,2,17,3,19,4,20,5,21,6,21,7,22,8,22,9,22,10,22,11,23,12,23,13,22,14,22,15,22,16,22,17,21,18,21,19,20,20,20,21,19,22,18,23,17,24,16,25,16,26,15,27,14,28,13,29,13,29,11,28,10,27,10,26,9,25,8,24,7,23,6,22,6,21,5,20,4,19,4,18,3,17,3,16,3,15,3,14,2,13,2,12,3,11,3,10,3,9,3,8,4,7,5,6,5,5,7,4,8,3,11,2,14,2]
	type: 'poly'



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
@marker_image         = orange_marker_image
@marker_shadow        = orange_marker_shadow
@marker_shape         = orange_marker_shape

@magic_marker_image         = orange_marker_image
@magic_marker_shadow        = orange_marker_shadow
@magic_marker_shape         = orange_marker_shape

