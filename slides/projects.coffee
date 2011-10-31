initialize = ->
  map = new google.maps.Map(document.getElementById("map_canvas"),
    center: defaultCenter
    zoom: zoom
    mapTypeId: google.maps.MapTypeId.ROADMAP
    mapTypeControl: true
    mapTypeControlOptions:
      style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR
      position: google.maps.ControlPosition.TOP_RIGHT
  )
  layer = new google.maps.FusionTablesLayer(tableid)
  layer.setQuery "SELECT 'geometry' FROM " + tableid
  layer.setMap map
  homeControlDiv = document.createElement("DIV")
  homeControl = new HomeControl(homeControlDiv, map)
  homeControlDiv.index = 1
  map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push homeControlDiv
  homeControlerDiv = document.createElement("DIV")
  homeControler = new HomeControler(homeControlerDiv, map)
  homeControlerDiv.index = 1
  map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push homeControlerDiv
  jbstate = document.getElementById("description2").className
  unless jbstate is "hide"
    document.getElementById("description2").className = "hide"
    document.getElementById("descriptionbox").className = ""
zoomtoaddress = ->
  geocoder.geocode
    address: document.getElementById("address").value
  , (results, status) ->
    if status is google.maps.GeocoderStatus.OK
      map.setCenter results[0].geometry.location
      map.setZoom 14
reset = ->
  map.setCenter defaultCenter
  map.setZoom zoom
enterSubmit = ->
  zoomtoaddress()  if event.keyCode is 13
changeMap = ->
  column1 = document.getElementById("c1").value.replace("'", "\\'")
  column2 = document.getElementById("c2").value.replace("'", "\\'")
  column3 = document.getElementById("c3").value.replace("'", "\\'")
  column4 = document.getElementById("c4").value.replace("'", "\\'")
  layer.setQuery "SELECT 'geometry' FROM " + tableid + " WHERE 'CompDate' NOT EQUAL TO 'Active' " + column1 + column2 + column3 + column4
HomeControl = (controlDiv, map) ->
  controlDiv.style.padding = "5px"
  controlUI = document.createElement("DIV")
  controlUI.style.backgroundColor = "white"
  controlUI.style.borderStyle = "solid"
  controlUI.style.borderWidth = "2px"
  controlUI.style.cursor = "pointer"
  controlUI.style.textAlign = "left"
  controlUI.title = "Legend"
  controlDiv.appendChild controlUI
  controlText = document.createElement("DIV")
  controlText.style.fontFamily = "Arial,sans-serif"
  controlText.style.fontSize = "12px"
  controlText.style.paddingLeft = "1em"
  controlText.style.paddingRight = "1em"
  controlText.innerHTML = "<b>Legend</b><ul style=\"list-type:circle;margin:0;padding-left:1em;paddding-top:0;\"><li style=\"list-style-image:url(smallgreen.png);\">On Time</li><li style=\"list-style-image:url(smallyellow.png);\">Warning</li><li style=\"list-style-image:url(smallred.png);\">Behind Schedule</li></ul><a href=\"http://www.google.com/fusiontables/DataSource?dsrcid=1643954\" target=\"_blank\" tabindex=\"90\">View on Google<br /> Fusion Tables</a><br/><a href=\"https://www.google.com/fusiontables/api/query?sql=SELECT+*+FROM+1643954\" target=\"_blank\" tabindex=\"95\">Download the file</a>"
  controlUI.appendChild controlText
HomeControler = (controlerDiv, map) ->
  controlerDiv.style.padding = "5px"
  controlerUI = document.createElement("DIV")
  controlerUI.style.cursor = "pointer"
  controlerUI.style.textAlign = "center"
  controlerUI.title = "MassDOT logo"
  controlerDiv.appendChild controlerUI
  controlerText = document.createElement("DIV")
  controlerText.style.fontFamily = "Arial,sans-serif"
  controlerText.style.fontSize = "12px"
  controlerText.style.paddingLeft = "4px"
  controlerText.style.paddingRight = "4px"
  controlerText.innerHTML = "<a href=\"http://www.massdot.state.ma.us/planning\" tabindex=\"96\"><img src=\"200px-Planninglogo_svg.png\" width=\"200\" alt=\"logo and link home\" border=\"0\"/></a>"
  controlerUI.appendChild controlerText
addOption_list = ->
  queryText1 = encodeURIComponent("SELECT 'ProjectNum', COUNT() FROM " + tableid + " GROUP BY 'ProjectNum'")
  query1 = new google.visualization.Query("http://www.google.com/fusiontables/gvizdata?tq=" + queryText1)
  query1.send getData1
  queryText2 = encodeURIComponent("SELECT 'PrjPrgress', COUNT() FROM " + tableid + " GROUP BY 'PrjPrgress'")
  query2 = new google.visualization.Query("http://www.google.com/fusiontables/gvizdata?tq=" + queryText2)
  query2.send getData2
  queryText3 = encodeURIComponent("SELECT 'Department', COUNT() FROM " + tableid + " GROUP BY 'Department'")
  query3 = new google.visualization.Query("http://www.google.com/fusiontables/gvizdata?tq=" + queryText3)
  query3.send getData3
  queryText4 = encodeURIComponent("SELECT 'BudgetSrc', COUNT() FROM " + tableid + " GROUP BY 'BudgetSrc'")
  query4 = new google.visualization.Query("http://www.google.com/fusiontables/gvizdata?tq=" + queryText4)
  query4.send getData4
getData1 = (response) ->
  numRows = response.getDataTable().getNumberOfRows()
  oneSelect = document.getElementById("c1")
  i = 0
  while i < numRows
    newoption = document.createElement("option")
    newoption.setAttribute "value", "AND 'ProjectNum' like '" + response.getDataTable().getValue(i, 0) + "'"
    newoption.innerHTML = response.getDataTable().getValue(i, 0)
    oneSelect.appendChild newoption
    i++
getData2 = (response) ->
  numRows = response.getDataTable().getNumberOfRows()
  twoSelect = document.getElementById("c2")
  i = 0
  while i < numRows
    newoption = document.createElement("option")
    newoption.setAttribute "value", "AND 'PrjPrgress' like '" + response.getDataTable().getValue(i, 0) + "'"
    newoption.innerHTML = response.getDataTable().getValue(i, 0)
    twoSelect.appendChild newoption
    i++
getData3 = (response) ->
  numRows = response.getDataTable().getNumberOfRows()
  threeSelect = document.getElementById("c3")
  i = 0
  while i < numRows
    newoption = document.createElement("option")
    newoption.setAttribute "value", "AND 'Department' like '" + response.getDataTable().getValue(i, 0) + "'"
    newoption.innerHTML = response.getDataTable().getValue(i, 0)
    threeSelect.appendChild newoption
    i++
getData4 = (response) ->
  numRows = response.getDataTable().getNumberOfRows()
  fourSelect = document.getElementById("c4")
  i = 0
  while i < numRows
    newoption = document.createElement("option")
    newoption.setAttribute "value", "AND 'BudgetSrc' like '" + response.getDataTable().getValue(i, 0) + "'"
    newoption.innerHTML = response.getDataTable().getValue(i, 0)
    fourSelect.appendChild newoption
    i++
SelectAll = (id) ->
  document.getElementById(id).focus()
  document.getElementById(id).select()
toggleInfo = ->
  state = document.getElementById("description").className
  if state is "hide"
    document.getElementById("description").className = ""
    document.getElementById("descriptionToggle").innerHTML = text[1]
    document.getElementById("description1").className = "hide"
    document.getElementById("descriptionToggle1").innerHTML = text1[0]
  else
    document.getElementById("description").className = "hide"
    document.getElementById("descriptionToggle").innerHTML = text[0]
toggleInfo1 = ->
  state = document.getElementById("description1").className
  if state is "hide"
    document.getElementById("description1").className = ""
    document.getElementById("descriptionToggle1").innerHTML = text1[1]
    document.getElementById("description").className = "hide"
    document.getElementById("descriptionToggle").innerHTML = text[0]
  else
    document.getElementById("description1").className = "hide"
    document.getElementById("descriptionToggle1").innerHTML = text1[0]
entertoggle = ->
  toggleInfo()  if event.keyCode is 13
entertoggle1 = ->
  toggleInfo1()  if event.keyCode is 13
google.load "visualization", "1", {}
map = undefined
geocoder = undefined
layer = undefined
tableid = 1643954
month = undefined
zoom = 8
defaultCenter = new google.maps.LatLng(42.04113400940814, -71.795654296875)
geocoder = new google.maps.Geocoder()
window.onkeypress = enterSubmit
showPopupOnHover = false
text = new Array("Search", "Hide")
text1 = new Array("Query", "Hide")
