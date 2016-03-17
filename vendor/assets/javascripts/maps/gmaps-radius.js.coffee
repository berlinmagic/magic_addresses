# https://github.com/obeattie/gmaps-radius/blob/gh-pages/static/js/gmaps-radius.coffee

earthRadii = {
  # The radius of the earth in various units
  mi: 3963.1676
  km: 6378.1
  ft: 20925524.9
  mt: 6378100
  in: 251106299
  yd: 6975174.98
  fa: 3487587.49
  na: 3443.89849
  ch: 317053.408
  rd: 1268213.63
  fr: 31705.3408
}


$ ->

  # if google? && jQuery("#partner_location_map").length > 0
  #   partner_data = $('#partner_location_map').data()
  #   lat = partner_data.latitude
  #   long = partner_data.longitude
  #   radius = (parseFloat( partner_data.radius ) / earthRadii["mt"]) * earthRadii['mt']
  #   that_circle = new google.maps.Circle({
  #     #center: e.latLng,
  #     center: new google.maps.LatLng( lat, long )
  #     clickable: false
  #     draggable: false
  #     editable: false
  #     map: map
  #     radius: radius
  #     # fillColor: '#004de8'
  #     # fillOpacity: 0.27
  #     # strokeColor: '#004de8'
  #     # strokeOpacity: 0.62
  #     fillColor: '#f23352'
  #     fillOpacity: 0.21
  #     strokeColor: '#f23352'
  #     strokeOpacity: 0.75
  #     strokeWeight: 1
  #   })
  #   console.log "Circle:", that_circle
  #   fill = "f23352"
  #   border = "ff3656"
  #   width = 640
  #   height = 640
  #   api_url = "http://maps.google.com.au/maps/api/staticmap?"
  #   map_radius_url = "#{api_url}center=#{partner_data.latitude},#{partner_data.longitude}&size=#{width}x#{height}&maptype=roadmap&path=fillcolor:0x#{fill}33%7Ccolor:0x#{border}00%7Cenc:#{that_circle}&sensor=false"
  #   jQuery("#partner_location_map").attr("href", map_radius_url)
    

  if google? && jQuery("#location_map").length > 0
    lat = $('#location_map').attr("data-latitude")
    long = $('#location_map').attr("data-longitude")
    map = new google.maps.Map($('#location_map')[0], {
      zoom: 11
      center: new google.maps.LatLng( lat, long )
      mapType: google.maps.MapTypeId.ROADMAP
    })
  
  
    polygonDestructionHandler = () ->
      @setMap(null)
    
    @circle
    
    circleDrawHandler = (e) =>
      # Get the radius in meters (since that's what Google requires)
      unitKey = "mt"
      radius = parseFloat( $('#company_work_location_attributes_radius').val() )
      radius = (radius / earthRadii[unitKey]) * earthRadii['mt']
      
      
      if radius > 91000
        console.log "zoom .. #{radius} > 91000"
        map.setZoom(4)
      else if radius > 71000
        console.log "zoom .. #{radius} > 71000"
        map.setZoom(5)
      else if radius > 51000
        console.log "zoom .. #{radius} > 51000"
        map.setZoom(6)
      else if radius > 31000
        console.log "zoom .. #{radius} > 31000"
        map.setZoom(7)
      else if radius > 21000
        console.log "zoom .. #{radius} > 21000"
        map.setZoom(8)
      else if radius > 11000
        console.log "zoom .. #{radius} > 11000"
        map.setZoom(9)
      else if radius > 7000
        console.log "zoom .. #{radius} > 7000"
        map.setZoom(10)
      else if radius > 4000
        console.log "zoom .. #{radius} > 4000"
        map.setZoom(10)
      else if radius > 1500
        console.log "zoom .. #{radius} > 1500"
        map.setZoom(11)
      else
        console.log "zoom .. #{radius} < 1500"
        map.setZoom(13)
      
      # polygonDestructionHandler( @circle ) if @circle
      
      google.maps.event.trigger( @circle, 'killCircle' ) if @circle
      
      @circle = new google.maps.Circle({
        #center: e.latLng,
        center: new google.maps.LatLng( lat, long )
        clickable: false
        draggable: false
        editable: false
        map: map
        radius: radius
        # fillColor: '#004de8'
        # fillOpacity: 0.27
        # strokeColor: '#004de8'
        # strokeOpacity: 0.62
        fillColor: '#f23352'
        fillOpacity: 0.21
        strokeColor: '#f23352'
        strokeOpacity: 0.75
        strokeWeight: 1
      })
      google.maps.event.addListener(@circle, 'loadCircle', circleDrawHandler)
      google.maps.event.addListener(@circle, 'killCircle', polygonDestructionHandler)
    
    google.maps.event.addListener(map, 'loadCircle', circleDrawHandler)
    
    circleDrawHandler()
    
    $( "#company_work_location_attributes_radius" ).change ->
      google.maps.event.trigger(map, 'loadCircle')
  