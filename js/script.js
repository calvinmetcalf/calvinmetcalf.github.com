/* Author:
Calvin Metcalf
*/
var eURL = 'http://baystatebikeweek.org/events/rss/';
//var eURL = 'calvinmetcalf.github.com/bf.xml';

 var yqlurl = 'http://query.yahooapis.com/v1/public/yql?format=json&q=select%20*%20from%20xml%20where%20url%3D';


$(function() {
$.get(yqlurl + "'" + encodeURIComponent(eURL) + "'",
        function(data){
          var v = data.query.results.rss.channel.item;
             $.each(v,function(i,ev){
                 var pts = ev.description.split("<br/>");
                 var stuff = '<tr><td>' + i + '</td><td>' + ev.title + '</td><td>' + pts[0] + '</td><td>' + pts[1] + '</td><td>' + pts[2] + '</td><td>' + pts[3] +'</td><td>' + ev.link + '</td></tr>';
                 
                 $('.events').append(stuff);
             }
            );
             $(".table").tablesorter();
        },"jsonp");
      
});