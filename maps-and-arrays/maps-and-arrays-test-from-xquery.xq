declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare namespace tan = "tag:textalign.net,2015:ns";

declare variable $json as xs:string external := ``[{
                                                     "items": [
                                                       {
                                                         "price": 2.5,
                                                         "name": "item1",
                                                         "categories": [ "cat1","cat3" ]
                                                       },
                                                       {
                                                         "price": 1.2,
                                                         "name": "item2",
                                                         "categories": [ "cat2","cat3" ]
                                                       },
                                                       {
                                                         "price": 5.6,
                                                         "name": "item3",
                                                         "categories": [ "cat1","cat4" ]
                                                       }
                                                     ],
                                                     "a": 1
                                                   }]``;



declare context item external := parse-json($json);

declare option output:method 'adaptive';
declare option output:indent 'yes';


transform(
  map {
    'stylesheet-location' : 'maps-and-arrays-module.xsl',
    'cache' : true(),
    'initial-function' : QName('tag:textalign.net,2015:ns', 'tan:map-put2'),
    'function-params' : [., 'price', 20, '?items?*[?categories = "cat3"]'],
    'delivery-format' : 'raw'
  }
)?output,


transform(
  map {
    'stylesheet-location' : 'maps-and-arrays-module.xsl',
    'cache' : true(),
    'initial-function' : QName('tag:textalign.net,2015:ns', 'tan:map-put2'),
    'function-params' : [map { 'a' : map { 'x' : 1, 'y' : 2 }, 'b' : 2 }, 'z', 3, '?a'],
    'delivery-format' : 'raw'
  }
)?output