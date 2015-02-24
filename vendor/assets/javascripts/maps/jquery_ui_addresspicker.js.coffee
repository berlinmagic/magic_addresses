#
# * jQuery UI addresspicker @VERSION
# *
# * Copyright 2010, AUTHORS.txt (http://jqueryui.com/about)
# * Dual licensed under the MIT or GPL Version 2 licenses.
# * http://jquery.org/license
# *
# * http://docs.jquery.com/UI/Progressbar
# *
# * Depends:
# *   jquery.ui.core.js
# *   jquery.ui.widget.js
# *   jquery.ui.autocomplete.js
# 
#  some improvements and coffeescript conversion by twetzel

(($, window, document) ->
  
  if google?
  
    $.widget "ui.addresspicker",
      options:
        appendAddressString: ""
        draggableMarker: true
        regionBias: null
        mapOptions:
          zoom: 5
          center: new google.maps.LatLng(52, 13)
          scrollwheel: false
          mapTypeId: google.maps.MapTypeId.ROADMAP
        elements:
          map: false
          lat: false
          lng: false
          locality: false
          sublocality: false
          administrative_area_level_1: false
          administrative_area_level_2: false
          administrative_area_level_3: false
          country: false
          postal_code: false
          type: false
          streetNumber: false
          route: false
          country_code: false
          formatted_address: false

      marker: ->
        @gmarker

      map: ->
        @gmap

      updatePosition: ->
        @_updatePosition @gmarker.getPosition()

      reloadPosition: ->
        @gmarker.setVisible true
        @gmarker.setPosition new google.maps.LatLng(@lat.val(), @lng.val())
        @gmap.setCenter @gmarker.getPosition()

      selected: ->
        @selectedResult

      _create: ->
        @geocoder = new google.maps.Geocoder()
        @element.autocomplete
          source: $.proxy(@_geocode, this)
          focus: $.proxy(@_focusAddress, this)
          select: $.proxy(@_selectAddress, this)

        @lat = $(@options.elements.lat)
        @lng = $(@options.elements.lng)
        @locality = $(@options.elements.locality)
        @sublocality = $(@options.elements.sublocality)
        @administrative_area_level_1 = $(@options.elements.administrative_area_level_1)
        @administrative_area_level_2 = $(@options.elements.administrative_area_level_2)
        @administrative_area_level_3 = $(@options.elements.administrative_area_level_3)
        @country = $(@options.elements.country)
        @country_code = $(@options.elements.country_code)
        @postal_code = $(@options.elements.postal_code)
        @streetNumber = $(@options.elements.streetNumber)
        @route = $(@options.elements.route)
        @type = $(@options.elements.type)
        @formatted_address = $(@options.elements.formatted_address)
        if @options.elements.map
          @mapElement = $(@options.elements.map)
          @_initMap()

      _initMap: ->
        @options.mapOptions.center = new google.maps.LatLng(@lat.val(), @lng.val())  if @lat and @lat.val()
        @gmap = new google.maps.Map(@mapElement[0], @options.mapOptions)
      
      
        @gmarker = new google.maps.Marker(
          position: @options.mapOptions.center
          map: @gmap
          draggable: @options.draggableMarker
          raiseOnDrag: true
          icon: magic_marker_image
          shadow: magic_marker_shadow
          shape: magic_marker_shape
        )
        google.maps.event.addListener @gmarker, "dragend", $.proxy(@_markerMoved, this)
        @gmarker.setVisible false

      _updatePosition: (location) ->
        @lat.val location.lat()  if @lat
        @lng.val location.lng()  if @lng

      _markerMoved: ->
        @_updatePosition @gmarker.getPosition()

    
      # Autocomplete source method: fill its suggests with google geocoder results
      _geocode: (request, response) ->
        address = request.term
        self = this
        @geocoder.geocode
          address: address + @options.appendAddressString
          language: "ru"
          # region: @options.regionBias
        , (results, status) ->
          if status is google.maps.GeocoderStatus.OK
            i = 0

            while i < results.length
              results[i].label = results[i].formatted_address
              i++
          response results


      _findInfo: (result, type) ->
        i = 0
        while i < result.address_components.length
          component = result.address_components[i]
          return component.long_name  unless component.types.indexOf(type) is -1
          i++
        false

      _findShortInfo: (result, type) ->
        i = 0
        while i < result.address_components.length
          component = result.address_components[i]
          return component.short_name unless component.types.indexOf(type) is -1
          i++
        false

      _focusAddress: (event, ui) ->
        address = ui.item
        return  unless address
      
        #console.log address
      
        if @gmarker
          @gmarker.setPosition address.geometry.location
          @gmarker.setVisible true
          @gmap.fitBounds address.geometry.viewport
        @_updatePosition address.geometry.location

        # Stadt
        if @locality
          if @_findInfo(address, "locality") then @locality.val @_findInfo(address, "locality") else @locality.val ""

        # Stadtteil
        if @sublocality
          if @_findInfo(address, "sublocality") then @sublocality.val @_findInfo(address, "sublocality") else @sublocality.val ""

        # Bundesland (Brandenburg)
        if @administrative_area_level_1
          if @_findInfo(address, "administrative_area_level_1")
            @administrative_area_level_1.val @_findInfo(address, "administrative_area_level_1")
          else
            @administrative_area_level_1.val ""

        # ? zeigt eine zweitrangige öffentliche Verwaltungseinheit unterhalb der Länderebene an
        if @administrative_area_level_2
          if @_findInfo(address, "administrative_area_level_2")
            @administrative_area_level_2.val @_findInfo(address, "administrative_area_level_2")
          else
            @administrative_area_level_2.val ""

        # Landkreis (Oberhavel)
        if @administrative_area_level_3
          if @_findInfo(address, "administrative_area_level_3")
            @administrative_area_level_3.val @_findInfo(address, "administrative_area_level_3")
          else
            @administrative_area_level_3.val ""

        # Strasse
        if @route
          if @_findInfo(address, "route") then @route.val @_findInfo(address, "route") else @route.val ""

        # Hausnummer
        if @streetNumber
          if @_findInfo(address, "street_number")
            @streetNumber.val @_findInfo(address, "street_number")
          else
            @streetNumber.val ""

        # Land
        if @country
          if @_findInfo(address, "country") then @country.val @_findInfo(address, "country") else @country.val ""

        # Land
        if @country_code
          if @_findShortInfo(address, "country") then @country_code.val @_findShortInfo(address, "country") else @country_code.val ""

        # Postleitzahl
        if @postal_code
          if @_findInfo(address, "postal_code")
            @postal_code.val @_findInfo(address, "postal_code")
          else
            @postal_code.val ""

        # Formartierte Adress
        # console?.log? "UI-ap :: ", address["formatted_address"]
        if @formatted_address
          if address["formatted_address"]
            @formatted_address.val address["formatted_address"]
          else
            @formatted_address.val ""


        console.log address
        
        @type.val address.types[0]  if @type


      _selectAddress: (event, ui) ->
        @selectedResult = ui.item
        if $(@element).closest(".map_form").find(".hidden_mgca_form").length > 0
          $(@element).closest(".map_form").find(".hidden_mgca_form").fadeIn()
          $(@element).fadeOut()
          if $(@element).closest(".map_form").find(".mgca_txt.street_number").val() == ""
            $(@element).closest(".map_form").find(".mgca_txt.street_number").focus()

    $.extend $.ui.addresspicker,
      version: "@VERSION"

  
    # make IE think it doesn't suck
    unless Array.indexOf
      Array::indexOf = (obj) ->
        i = 0

        while i < @length
          return i  if this[i] is obj
          i++
        -1

)(jQuery, window, document)