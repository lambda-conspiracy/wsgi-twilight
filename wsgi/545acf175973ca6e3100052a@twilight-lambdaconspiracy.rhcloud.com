pax_global_header                                                                                   0000666 0000000 0000000 00000000064 12350734651 0014520 g                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        52 comment=cefaf389c6a629db60ad1787266cc535dea904a8
                                                                                                                                                                                                                                                                                                                                                                                                                                                                            geocoder-0.6.0/                                                                                     0000775 0000000 0000000 00000000000 12350734651 0013312 5                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        geocoder-0.6.0/.gitignore                                                                           0000664 0000000 0000000 00000000473 12350734651 0015306 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        *.py[cod]

# C extensions
*.so

# Packages
*.egg
*.egg-info
dist
build
eggs
parts
bin
var
sdist
develop-eggs
.installed.cfg
lib
lib64
__pycache__

# Installer logs
pip-log.txt

# Unit test / coverage reports
.coverage
.tox
nosetests.xml

# Translations
*.mo

# Mr Developer
.mr.developer.cfg
.project
.pydevproject
                                                                                                                                                                                                     geocoder-0.6.0/.travis.yml                                                                          0000664 0000000 0000000 00000000510 12350734651 0015417 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        language: python
python:
  - "2.6"
  - "2.7"
  # does not have headers provided, please ask https://launchpad.net/~pypy/+archive/ppa
  # maintainers to fix their pypy-dev package.
  - "pypy"
# command to install dependencies
install:
  - pip install .
  - pip install -r requirements.txt

# command to run tests
script: py.test
                                                                                                                                                                                        geocoder-0.6.0/AUTHORS.md                                                                           0000664 0000000 0000000 00000000154 12350734651 0014761 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        Geocoder is written and maintained by Denis Carriere.

# Development Lead

- Denis Carriere <info@addxy.com>                                                                                                                                                                                                                                                                                                                                                                                                                    geocoder-0.6.0/LICENSE                                                                              0000664 0000000 0000000 00000001105 12350734651 0014314 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        Copyright 2014 Denis Carriere

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.                                                                                                                                                                                                                                                                                                                                                                                                                                                           geocoder-0.6.0/MANIFEST.in                                                                          0000664 0000000 0000000 00000000123 12350734651 0015044 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        include README.md
include LICENSE
include test_geocoder.py
include requirements.txt                                                                                                                                                                                                                                                                                                                                                                                                                                             geocoder-0.6.0/README.md                                                                            0000664 0000000 0000000 00000013211 12350734651 0014567 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        # [Geocoder](https://github.com/DenisCarriere/geocoder) [![version](https://badge.fury.io/py/geocoder.png)](http://badge.fury.io/py/geocoder) [![build](https://travis-ci.org/DenisCarriere/geocoder.png?branch=master)](https://travis-ci.org/DenisCarriere/geocoder)

A simplistic Python Geocoder.

Geocoder is an Apache2 Licensed Geocoding library, written in Python.


```python
>>> import geocoder
>>> g = geocoder.google('Moscone Center')
>>> g.latlng
(37.784173, -122.401557)
>>> g.city
'San Francisco'
...
```

## Providers

![Providers](https://pbs.twimg.com/media/Bqi8kThCUAAboo0.png)

# Installation

You can install, upgrade, uninstall Geocoder with these commands:

```bash
$ pip install geocoder
$ pip install --upgrade geocoder
$ pip uninstall geocoder
```

# Documentation

## Search with Google

Using the Geocoder API from Google, this is a simplistic approach
to return you all the same results that Google would provide.

```python
>>> import geocoder
>>> g = geocoder.google('1600 Amphitheatre Pkwy, Mountain View, CA')
>>> g.latlng
(37.784173, -122.401557)
>>> g.postal
'94043'
>>> g.city
'Mountain View'
>>> g.country
'United States'
...
```

## Long names with Google

When using Google, the default results are using the short names, here is how you would
retrieve the long names as the results.

```python
>>> g = geocoder.google(<address>, short_name=False)
```

## Elevation Tool (MSL)

Elevation tool will return the Mean elevation above Sea Level in meters based
on Lat & Lng inputs or an address using Google's elevation API.

```python
>>> latlng = (37.4192, -122.0574)
>>> g = geocoder.elevation(latlng)
OR
>>> g = geocoder.elevation("Ottawa")
>>> g.elevation
'71.8073501587'
...
```

## Getting JSON

The web uses JSON and GeoJSON, here is how to return your Geocoded address into this format.

```python
>>> g = geocoder.google('1600 Amphitheatre Parkway, Mountain View, CA')
>>> g.json
{'address': '1600 Amphitheatre Parkway, Mountain View, CA 94043, USA',
'bbox': {'northeast': {'lat': 37.4233474802915, 'lng': -122.0826054197085},
'southwest': {'lat': 37.4206495197085, 'lng': -122.0853033802915}},
'city': 'Mountain View',
'country': 'United States',
'lat': 37.4219985,
'lng': -122.0839544,
'location': '1600 Amphitheatre Parkway, Mountain View, CA 94043, USA',
'ok': True,
'postal': '94043',
'provider': 'Google',
'quality': 'ROOFTOP',
'status': 'OK'}
...
```

GeoJSON is a widely used, open format for encoding geographic data, and is supported by a number of popular applications.

```python
>>> import simplejson as json
>>> g = geocoder.google('Ottawa, ON')
>>> json.dumps(g.geojson, indent=4)
{
"geometry": {
    "type": "Point",
    "coordinates": [
        -75.69719309999999,
        45.4215296
    ]
},
"crs": {
    "type": "name",
    "properties": {
        "name": "urn:ogc:def:crs:OGC:1.3:CRS84"
    }
},
"type": "Feature",
"properties": {
    "status": "OK",
    "city": "Ottawa",
    "ok": true,
    "country": "Canada",
...
```

## Using Proxies & Timeout

There many obvious reasons why you would need to use proxies,
here is the basic syntax on how to successfully use them.

Timeouts are used to stop the connection if it reaches a certain time.

```python
>>> proxies = '111.161.126.84:80'
>>> g = geocoder.google('Ottawa', proxies=proxies, timeout=5.0)
<[OK] Geocoder Google [Ottawa, ON, Canada]>
...
```

## Reverse Geocoding

Using Google's reverse geocoding API, you are able to input a set of coordinates and geocode its location.

```python
>>> latlng = (48.85837, 2.2944813)
>>> g = geocoder.reverse(latlng)
<[OK] Geocoder Google [Eiffel Tower, Paris, France]>
...
```

## Bounding Box (Extent)

```python
>>> g = geocoder.osm('1600 Amphitheatre Pkwy, Mountain View, CA')
>>> g.bbox
{'northeast': {'lat': 37.4233474802915, 'lng': -122.0826054197085},
'southwest': {'lat': 37.4206495197085, 'lng': -122.0853033802915}}
>>> g.southwest
{'lat': 37.4206495197085, 'lng': -122.0853033802915}
>>> g.south
37.4206495197085
...
```

## Geocoding IP Address

Retrieves geocoding data from MaxMind's GeoIP2 services

```python
>>> g = geocoder.ip('74.125.226.99')
>>> g.address
'Mountain View, California United States'
>>> g.latlng
(37.4192, -122.0574)
```

Geocoding your current IP address, simply use **me** as the input.

```python
>>> g = geocoder.ip('me')
>>> g.address
'Ottawa, Ontario Canada'
>>> g.latlng
(45.4805, -75.5237)
...
```

## Population Data from City

Retrieves population data from Geonames's Web Service API.

```python
>>> pop = geocoder.population('Springfield, Virginia')
>>> pop
30484
...
```

## Geocoder Attributes

- address
- street_number
- route
- neighborhood
- sublocality
- locality
- state
- division
- country
- postal
- quality
- status
- population (integer)
- ok (boolean)
- x, lng, longitude (float)
- y, lat, latitude (float)
- latlng, xy (tuple)
- bbox {southwest, northeast}
- southwest {lat, lng}
- northeast {lat, lng}
- south, west, north, east (float)


## Support

This project is free & open source, it would help greatly for you guys reading this to contribute, here are some of the ways that you can help make this Python Geocoder better.

## Feedback

Please feel free to give any feedback on this module. If you find any bugs or any enhancements to recommend please send some of your comments/suggestions to the [Github Issues Page](https://github.com/DenisCarriere/geocoder/issues).

## Twitter

Speak up on Twitter and tell us how you use this Python Geocoder module by using the following Twitter Hashtags [@Addxy](https://twitter.com/search?q=%40Addxy) [#geocoder](https://twitter.com/search?q=%23geocoder).

## Thanks to

A big thanks to all the people that help contribute: [@flebel](https://github.com/flebel) @[patrickyan](https://github.com/patrickyan)
                                                                                                                                                                                                                                                                                                                                                                                       geocoder-0.6.0/examples/                                                                            0000775 0000000 0000000 00000000000 12350734651 0015130 5                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        geocoder-0.6.0/examples/bing.py                                                                     0000664 0000000 0000000 00000000177 12350734651 0016426 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

import geocoder

g = geocoder.bing('Ottawa, ON')

print g.address
print g.latlng
print g.json                                                                                                                                                                                                                                                                                                                                                                                                 geocoder-0.6.0/examples/elevation.py                                                                0000664 0000000 0000000 00000000261 12350734651 0017467 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

import geocoder

latlng = (45.4215296, -75.6971931)
g = geocoder.elevation(latlng)
#OR
g = geocoder.elevation("Ottawa, ON")

print g.elevation
                                                                                                                                                                                                                                                                                                                                               geocoder-0.6.0/examples/google.py                                                                   0000664 0000000 0000000 00000000201 12350734651 0016747 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

import geocoder

g = geocoder.google('Ottawa, ON')

print g.address
print g.latlng
print g.json                                                                                                                                                                                                                                                                                                                                                                                               geocoder-0.6.0/examples/ip.py                                                                       0000664 0000000 0000000 00000000214 12350734651 0016107 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

import geocoder

g = geocoder.ip('199.7.XXX.XX')
#OR
g = geocoder.ip('me')

print g.address
print g.latlng                                                                                                                                                                                                                                                                                                                                                                                    geocoder-0.6.0/geocoder/                                                                            0000775 0000000 0000000 00000000000 12350734651 0015101 5                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        geocoder-0.6.0/geocoder/__init__.py                                                                 0000664 0000000 0000000 00000001161 12350734651 0017211 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

"""
geocoder library
~~~~~~~~~~~~~~~~

A simplistic Python Geocoder.

Geocoder is an Apache2 Licensed Geocoding library, written in Python.

    >>> import geocoder
    >>> g = geocoder.google('Moscone Center')
    >>> g.latlng
    (37.784173, -122.401557)
    >>> g.city
    'San Francisco'
    ...

"""

__title__ = 'geocoder'
__version__ = '0.6.0'
__author__ = 'Denis Carriere'
__license__ = 'Apache 2.0'
__copyright__ = 'Copyright 2014 Denis Carriere'


from api import arcgis, bing, geonames, google, mapquest, nokia, osm, tomtom
from api import get, population, reverse, ip, elevation
                                                                                                                                                                                                                                                                                                                                                                                                               geocoder-0.6.0/geocoder/api.py                                                                      0000664 0000000 0000000 00000016563 12350734651 0016237 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

import utils
from keys import *
from ip import Ip
from osm import Osm
from bing import Bing
from nokia import Nokia
from arcgis import Arcgis
from tomtom import Tomtom
from google import Google
from reverse import Reverse
from geonames import Geonames
from mapquest import Mapquest
from geocoder import Geocoder
from elevation import Elevation

def google(location, short_name=True, timeout=5.0, proxies='', client='', secret='', api_key=''):
    """
    Retrieves geocoding data from Google's geocoding API V3

        >>> g = geocoder.google('1600 Amphitheatre Pkwy, Mountain View, CA')
        >>> g.latlng
        (37.784173, -122.401557)
        >>> g.country
        'United States'
        ...

    Official Docs
    -------------
    https://developers.google.com/maps/documentation/geocoding/
    """
    provider = Google(location, short_name=short_name, client=client, secret=secret, api_key=api_key)
    return Geocoder(provider, proxies=proxies, timeout=timeout)


def get(location, provider='google', proxies='', short_name=True, timeout=5.0):
    """
    Retrieves geocoding data from Google's geocoding API V3

        >>> g = geocoder.search('123 Address', provider='google')
        >>> g.latlng
        (37.784173, -122.401557)
        >>> g.country
        'United States'
        ...
    """
    provider = utils.get_provider(location, provider=provider, short_name=short_name)
    return Geocoder(provider, proxies=proxies, timeout=timeout)

def ip(location, proxies='', timeout=5.0):
    """
    Geocodes an IP address using MaxMind's services.

        >>> g = geocoder.ip('74.125.226.99')
        >>> g.latlng
        (37.4192, -122.0574)
        >>> g.address
        'Mountain View, California United States'
        ...

    Official Docs
    -------------
    http://www.maxmind.com/en/geolocation_landing
    """
    provider = Ip(location)
    return Geocoder(provider, proxies=proxies, timeout=timeout)


def elevation(latlng, proxies='', timeout=5.0):
    """
    Elevation tool will return the Mean elevation above Sea Level in meters based
    on Lat & Lng inputs or an address using Google's elevation API.

        >>> latlng = (37.4192, -122.0574)
        >>> g = geocoder.elevation(latlng)
        OR
        >>> g = geocoder.elevation("Ottawa")
        >>> g.elevation
        '71.8073501587'
        ...

    Official Docs
    -------------
    https://developers.google.com/maps/documentation/geocoding/
    """
    provider = Elevation(latlng)
    return Geocoder(provider, proxies=proxies, timeout=timeout)


def reverse(latlng, short_name=True, proxies='', timeout=5.0):
    """
    Reverse geocodes a location based on Lat & Lng inputs
    using Google's reverse geocoding API V3.

        >>> latlng = (37.4192, -122.0574)
        >>> g = geocoder.reverse(latlng)
        >>> g.address
        'Sevryns Road, Mountain View, CA 94043, USA'
        >>> g.postal
        '94043'
        ...

    Official Docs
    -------------
    https://developers.google.com/maps/documentation/geocoding/
    """
    provider = Reverse(latlng, short_name=short_name)
    return Geocoder(provider, proxies=proxies, timeout=timeout)



def osm(location, proxies='', timeout=5.0):
    """
    Retrieves geocoding data from OSM's data using Nominatim's geocoding API.

        >>> g = geocoder.osm('Tacloban City')
        >>> g.latlng
        (11.2430274, 125.0081402)
        >>> g.country
        'Philippines'
        ...

    Official Docs
    -------------
    http://wiki.openstreetmap.org/wiki/Nominatim
    """
    provider = Osm(location)
    return Geocoder(provider, proxies=proxies, timeout=timeout)


def arcgis(location, proxies='', timeout=5.0):
    """
    Retrieves geocoding data from ArcGIS's REST geocoding API.

        >>> g = geocoder.arcgis('380 New York St, Redlands, California')
        >>> g.latlng
        (34.05649072776595, -117.19566584280369)
        >>> g.postal
        '92373'
        ...

    Official Docs
    -------------
    http://resources.arcgis.com/en/help/arcgis-rest-api/
    """
    provider = Arcgis(location)
    return Geocoder(provider, proxies=proxies, timeout=timeout)


def mapquest(location, proxies='', timeout=5.0):
    """
    Retrieves geocoding data from MapQuest's address geocoding API.

        >>> g = geocoder.mapquest('1555 Blake street, Denver')
        >>> g.latlng
        (39.740009, -104.992264)
        >>> g.quality
        'CITY'
        ...

    Official Docs
    -------------
    http://www.mapquestapi.com/geocoding/
    """
    provider = Mapquest(location)
    return Geocoder(provider, proxies=proxies, timeout=timeout)


def tomtom(location, key=tomtom_key, proxies='', timeout=5.0):
    """
    Retrieves geocoding data from TomTom's geocoding API.

        >>> key = 'XXXXX'
        >>> g = geocoder.tomtom('Amsterdam, Netherlands', key=key)
        >>> g.latlng
        (52.373166, 4.89066)
        >>> g.quality
        'city'
        ...

    Official Docs
    -------------
    http://developer.tomtom.com/products/geocoding_api
    """
    provider = Tomtom(location, key=key)
    return Geocoder(provider, proxies=proxies, timeout=timeout)


def bing(location, key=bing_key, proxies='', timeout=5.0):
    """
    Retrieves geocoding data from Bing's REST location API.

        >>> key = 'XXXXX'
        >>> g = geocoder.bing('Medina, Washington', key=key)
        >>> g.latlng
        (47.615821838378906, -122.23892211914062)
        >>> g.country
        'United States'
        ...

    Official Docs
    -------------
    http://msdn.microsoft.com/en-us/library/ff701714.aspx
    """
    provider = Bing(location, key=key)
    return Geocoder(provider, proxies=proxies, timeout=timeout)


def nokia(location, app_id=app_id, app_code=app_code, proxies='', timeout=5.0):
    """
    Retrieves geocoding data from Nokia's HERE geocoder API.

        >>> app_id = 'XXXXX'
        >>> app_code = 'XXXXX'
        >>> g = geocoder.nokia('Keilaniemi, Espoo')
        >>> g.latlng
        (60.1759338, 24.8327808)
        >>> g.country
        'FIN'
        ...

    Official Docs
    -------------
    https://developer.here.com/rest-apis/documentation/geocoder
    """
    provider = Nokia(location, app_id=app_id, app_code=app_code)
    return Geocoder(provider, proxies=proxies, timeout=timeout)


def geonames(location, username=username, proxies='', timeout=5.0):
    """
    Retrieves geocoding data from Geonames's Web Service API.

        >>> username = 'XXXXX'
        >>> g = geocoder.geonames('Springfield, Virginia', username=username)
        >>> g.latlng
        (38.78928, -77.1872)
        >>> g.country
        'United States'
        >>> g.population
        30484
        ...

    Official Docs
    -------------
    http://www.geonames.org/export/web-services.html
    """
    provider = Geonames(location, username=username)
    return Geocoder(provider, proxies=proxies, timeout=timeout)


def population(location, username=username, proxies='', timeout=5.0):
    """
    Retrieves the population data from Geonames's Web Service API.

        >>> username = 'XXXXX'
        >>> pop = geocoder.population('Springfield, Virginia')
        >>> pop
        30484
        ...

    Official Docs
    -------------
    http://www.geonames.org/export/web-services.html
    """
    g = geonames(location, username=username, proxies=proxies, timeout=timeout)
    return g.pop

if __name__ == '__main__':
    a = (45.4215296, -75.69719309999999)
    g = reverse(a)
    print g                                                                                                                                             geocoder-0.6.0/geocoder/arcgis.py                                                                   0000664 0000000 0000000 00000002272 12350734651 0016726 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base


class Arcgis(Base):
    name = 'ArcGIS'
    url = 'http://geocode.arcgis.com/arcgis/rest/'
    url += 'services/World/GeocodeServer/find'

    def __init__(self, location):
        self.location = location
        self.json = dict()
        self.params = dict()
        self.params['text'] = location
        self.params['maxLocations'] = 1
        self.params['f'] = 'pjson'

    @property
    def lat(self):
        return self.safe_coord('geometry-y')

    @property
    def lng(self):
        return self.safe_coord('geometry-x')

    @property
    def address(self):
        return self.safe_format('locations-name')

    @property
    def quality(self):
        return self.safe_format('attributes-Addr_Type')

    @property
    def postal(self):
        # Using Regular Expression to find Postal Code
        if self.address:
            return self.safe_postal(self.address)

    @property
    def bbox(self):
        south = self.json.get('extent-ymin')
        west = self.json.get('extent-xmin')
        north = self.json.get('extent-ymax')
        east = self.json.get('extent-xmax')
        return self.safe_bbox(south, west, north, east)
                                                                                                                                                                                                                                                                                                                                      geocoder-0.6.0/geocoder/base.py                                                                     0000664 0000000 0000000 00000012161 12350734651 0016366 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

import re


class Base(object):
    """ Template for Providers """
    headers = None
    params = None
    bbox = None
    x = None
    y = None
    west = None
    north = None
    south = None
    east = None
    northeast = None
    northwest = None
    southwest = None
    southeast = None
    population = None
    bbox = None
    quality = None
    postal = None
    neighborhood = None
    country = None
    city = None
    route = None
    street_number = None
    locality = None
    sublocality = None
    county = None
    state = None
    ip = None
    status = None
    short_name = None
    elevation = None
    resolution = None
    isp = None

    def __init__(self):
        self.json = dict()
        self.headers = dict()

    def __repr__(self):
        return "<{0} [{1}]>".format(self.name, self.location)

    def load(self, json, last=''):
        # DICTIONARY
        if isinstance(json, dict):
            for keys, values in json.items():
                # MAXMIND
                if 'geoname_id' in json:
                    names = json.get('names')
                    self.json[last] = names['en']


                # NOKIA
                if keys in 'AdditionalData':
                    for item in values:
                        key = item.get('key')
                        value = item.get('value')
                        self.json[key] = value

                # GOOGLE
                if keys == 'results':
                    if values:
                        self.load(values[0], keys)

                elif keys == 'address_components':
                    for item in values:
                        short_name = item.get('short_name')
                        long_name = item.get('long_name')
                        all_types = item.get('types')
                        for types in all_types:
                            self.json[types] = short_name
                            self.json[types + '-long_name'] = long_name

                elif keys == 'types':
                    for item in values:
                        name = 'types_{0}'.format(item)
                        self.json[name] = True

                # LIST
                elif isinstance(values, list):
                    if len(values) == 1:
                        self.load(values[0], keys)
                    elif len(values) > 1:
                        for count, value in enumerate(values):
                            name = '{0}-{1}'.format(keys, count)
                            self.load(value, name)

                # DICTIONARY
                elif isinstance(values, dict):
                    self.load(values, keys)
                else:
                    if last:
                        name = '{0}-{1}'.format(last, keys)
                    else:
                        name = keys
                    self.json[name] = values
        # LIST
        elif isinstance(json, (list, tuple)):
            if json:
                self.load(json[0], last)
        # OTHER Formats
        else:
            self.json[last] = json

    def safe_postal(self, item):
        # Full postal code - K1E 1S9
        expression = r"[A-Z]{1}[0-9]{1}[A-Z]{1}[ ]?[0-9]{1}[A-Z]{1}[0-9]{1}"
        # Partial postal code - K1E
        expression += r"([A-Z]{1}[0-9]{1}[A-Z]{1})?"
        pattern = re.compile(expression)
        if item:
            match = pattern.search(item)

            # Canada Pattern
            if match:
                return match.group()
            else:
                # United States Pattern
                pattern = re.compile(r'[0-9]{5}([0-9]{4})?')
                match = pattern.search(item)
                if match:
                    return match.group()
        return None

    def safe_format(self, item):
        item = self.json.get(item)
        if item:
            item = item
        return item

    def safe_coord(self, item):
        item = self.json.get(item)
        if item:
            try:
                return float(item)
            except:
                return None
        else:
            return None

    def safe_bbox(self, south, west, north, east):
        # South Latitude, West Longitude, North Latitude, East Longitude
        try:
            self.south = float(south)
            self.west = float(west)
            self.north = float(north)
            self.east = float(east)
        except:
            self.south = None
            self.west = None
            self.north = None
            self.east = None

        if bool(self.south and self.east and self.north and self.west):
            self.southwest = {'lat': self.south, 'lng': self.west}
            self.southeast = {'lat': self.south, 'lng': self.east}
            self.northeast = {'lat': self.north, 'lng': self.east}
            self.northwest = {'lat': self.north, 'lng': self.west}
            bbox = {'southwest': self.southwest, 'northeast': self.northeast}
            return bbox
        return None

    @property
    def ok(self):
        return bool(self.lng and self.lat)

    @property
    def status(self):
        if self.lng:
            return 'OK'
        else:
            return 'ERROR - No Geometry'                                                                                                                                                                                                                                                                                                                                                                                                               geocoder-0.6.0/geocoder/bing.py                                                                     0000664 0000000 0000000 00000003721 12350734651 0016375 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base


class Bing(Base):
    name = 'Bing'
    url = 'http://dev.virtualearth.net/REST/v1/Locations'

    def __init__(self, location, key):
        self.location = location
        self.params = dict()
        self.json = dict()
        self.params['maxResults'] = 1
        self.params['key'] = key
        self.params['q'] = location
        if not key:
            self.help_key()

    @property
    def lat(self):
        return self.safe_coord('coordinates-0')

    @property
    def lng(self):
        return self.safe_coord('coordinates-1')

    @property
    def route(self):
        return self.safe_format('address-addressLine')

    @property
    def address(self):
        return self.safe_format('address-formattedAddress')

    @property
    def status(self):
        return self.safe_format('statusDescription')

    @property
    def quality(self):
        return self.safe_format('resources-entityType')

    @property
    def postal(self):
        return self.safe_format('address-postalCode')

    @property
    def bbox(self):
        south = self.json.get('bbox-0')
        west = self.json.get('bbox-1')
        north = self.json.get('bbox-2')
        east = self.json.get('bbox-3')
        return self.safe_bbox(south, west, north, east)

    @property
    def locality(self):
        return self.safe_format('address-locality')

    @property
    def state(self):
        return self.safe_format('address-adminDistrict')

    @property
    def country(self):
        return self.safe_format('address-countryRegion')

    def help_key(self):
        print '<ERROR>'
        print 'Please provide a <key> paramater when using Bing'
        print '    >>> import geocoder'
        print '    >>> key = "XXXX"'
        print '    >>> g = geocoder.bing(<location>, key=key)'
        print ''
        print 'How to get a Key?'
        print '-----------------'
        print 'http://msdn.microsoft.com/en-us/library/ff428642.aspx'
                                               geocoder-0.6.0/geocoder/elevation.py                                                                0000664 0000000 0000000 00000001663 12350734651 0017447 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base
from google import Google
from location import Location


class Elevation(Google, Base):
    name = 'Elevation Google'
    url = 'http://maps.googleapis.com/maps/api/elevation/json'

    def __init__(self, latlng):
        self.location = latlng
        self.json = dict()
        self.params = dict()
        lat, lng = Location(latlng).latlng
        self.latlng = '{0},{1}'.format(lat, lng)

        # Parameters for URL request
        self.params['locations'] = self.latlng

    @property
    def elevation(self):
        return self.safe_format('results-elevation')

    @property
    def resolution(self):
        return self.safe_format('results-resolution')

if __name__ == '__main__':
    from api import Geocoder
    latlng = (45.4215296, -75.69719309999999)
    provider = Elevation(latlng)
    g = Geocoder(provider)
    print g.resolution
    print g.elevation
    print g.json                                                                             geocoder-0.6.0/geocoder/geocoder.py                                                                 0000664 0000000 0000000 00000020111 12350734651 0017235 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

import requests
import sys
import os
try:
    import simplejson as json
except:
    import json


class Geocoder(object):
    """
    geocoder object
    ~~~~~~~~~~~~~~~
    >>> g = geocoder.google('1600 Amphitheatre Pkwy, Mountain View, CA')
    >>> g.latlng
    (37.784173, -122.401557)
    >>> g.country
    'United States'
    """
    def __init__(self, provider, proxies='', timeout=5.0):
        self.provider = provider
        self.proxies = proxies
        self.timeout = timeout
        self.name = provider.name

        # Connecting to HTTP provider
        self._get_proxies()
        self._get_timeout()
        self._connect()
        self._add_data()

    def __repr__(self):
        return '<[{0}] Geocoder {1} [{2}]>'.format(self.status, self.name, self.address)

    def save(self, filepath, ext='geojson'):
        """
        Saves Geocoded date to a local file.

            >>> g = geocoder.google(<address>)
            >>> g.save('GoogleResult.geojson')
            ...
        """
        basename, ext = os.path.splitext(filepath)
        if ext == '.geojson':
            data = self.geojson
        elif ext == '.json':
            data = self.json
        else:
            data = self.geojson

        with open(filepath, 'wb') as f:
            dump = json.dumps(data, ensure_ascii=False, indent=4)
            f.write(dump)

    def _get_proxies(self):
        if self.proxies:
            if isinstance(self.proxies, str):
                if 'http://' not in self.proxies:
                    name = 'http://{0}'.format(self.proxies)
                self.proxies = {'http': name}
        else:
            self.proxies = {}

    def _get_timeout(self):
        if isinstance(self.timeout, int):
            self.timeout = float(self.timeout)

    def _connect(self):
        """ Requests the Geocoder's URL with the Address as the query """
        self.url = ''
        self.status = 404
        try:
            r = requests.get(
                self.provider.url,
                params=self.provider.params,
                headers=self.provider.headers,
                timeout=self.timeout,
                proxies=self.proxies
            )
            self.url = r.url
            self.status = r.status_code
        except KeyboardInterrupt:
            sys.exit()
        except:
            self.status = 'ERROR - URL Connection'

        if self.status == 200:
            try:
                self.provider.load(r.json())
                self.status = self.provider.status
            except:
                self.status = 'ERROR - JSON Corrupt'

    def _add_data(self):
        # Get Attributes from Provider
        self.quality = self.provider.quality
        self.ok = self.provider.ok
        self.quality = self.provider.quality
        self.location = self.provider.location

        # Geometry
        self.lng = self.provider.lng
        self.lat = self.provider.lat
        self.bbox = self.provider.bbox

        # Address
        self.address = self.provider.address
        self.postal = self.provider.postal
        self.street_number = self.provider.street_number
        self.route = self.provider.route
        self.neighborhood = self.provider.neighborhood
        self.sublocality = self.provider.sublocality
        self.locality = self.provider.locality
        self.county = self.provider.county
        self.state = self.provider.state
        self.country = self.provider.country

        # Alternate Names
        self.street_name = self.route
        self.street = self.route
        self.district = self.neighborhood
        self.city = self.locality
        self.admin2 = self.county
        self.division = self.county
        self.admin1 = self.state
        self.province = self.state

        # More ways to spell X.Y
        x, y = self.lng, self.lat
        self.x, self.longitude = x, x
        self.y, self.latitude = y, y
        self.latlng = (self.lat, self.lng)
        self.xy = (x, y)

        # Bounding Box - SouthWest, NorthEast - [y1, x1, y2, x2]
        self.south = self.provider.south
        self.west = self.provider.west
        self.southwest = self.provider.southwest
        self.southeast = self.provider.southeast
        self.north = self.provider.north
        self.east = self.provider.east
        self.northeast = self.provider.northeast
        self.northwest = self.provider.northwest

        # Population Field (integer)
        self.population = self.provider.population
        self.pop = self.population

        # IP Address
        self.ip = self.provider.ip
        self.isp = self.provider.isp

        # Geom for PostGIS
        self.geom = "ST_GeomFromText('POINT({0} {1})', 4326)".format(self.lng, self.lat)

        # Build Elevation
        self.elevation = self.provider.elevation
        self.resolution = self.provider.resolution

        # Build JSON
        self.json = self._build_json()
        self.geojson = self._build_geojson()


    def _build_json(self):
        json = dict()
        json['provider'] = self.name
        json['location'] = self.location
        json['ok'] = self.ok
        json['status'] = self.status
        json['url'] = self.url

        if self.postal:
            json['postal'] = self.postal

        if self.address:
            json['address'] = self.address

        if self.ok:
            json['quality'] = self.quality
            json['lng'] = self.x
            json['lat'] = self.y

        if self.isp:
            json['isp'] = self.isp

        if self.bbox:
            json['bbox'] = self.bbox

        if self.street_number:
            json['street_number'] = self.street_number

        if self.route:
            json['route'] = self.route

        if self.neighborhood:
            json['neighborhood'] = self.neighborhood

        if self.sublocality:
            json['sublocality'] = self.sublocality

        if self.locality:
            json['locality'] = self.locality

        if self.county:
            json['county'] = self.county

        if self.state:
            json['state'] = self.state

        if self.country:
            json['country'] = self.country

        if self.population:
            json['population'] = self.population

        if self.ip:
            json['ip'] = self.ip

        if self.elevation:
            json['elevation'] = self.elevation
            json['resolution'] = self.resolution
            self.address = self.elevation

        return json

    def _build_geojson(self):
        geojson = dict()
        if self.bbox:
            geojson['bbox'] = [self.west, self.south, self.east, self.north]
        geojson['type'] = 'Feature'
        geojson['geometry'] = {'type':'Point', 'coordinates': [self.lng, self.lat]}
        geojson['properties'] = self.json
        geojson['crs'] = {'type': 'name', "properties": {"name": "urn:ogc:def:crs:OGC:1.3:CRS84"}}
        return geojson


    def debug(self):
        print '============'
        print 'Debug Geocoder'
        print '-------------'
        print 'Provider:', self.name
        print 'Location:', self.location
        print 'Lat & Lng:', self.latlng
        print 'Bbox:', self.bbox
        print 'OK:', self.ok
        print 'Status:', self.status
        print 'Quality:', self.quality
        print 'Url:', self.url
        print 'Proxies:', self.proxies
        print ''
        print 'Address'
        print '-------'
        print 'Address: ', self.address
        print 'Postal:', self.postal
        print 'Street Number:', self.street_number
        print 'Route:', self.route
        print 'Neighborhood:', self.neighborhood
        print 'SubLocality:', self.sublocality
        print 'Locality:', self.locality
        print 'City:', self.city
        print 'County:', self.county
        print 'State:', self.state
        print 'Country:', self.country
        print '============'
        print 'JSON Objects'
        print '------------'
        for item in self.provider.json.items():
            print item

if __name__ == '__main__':
    from google import Google
    location = 'Olreans, Ottawa'

    provider = Google(location)
    g = Geocoder(provider)
    print g
    print g.url
    
    os
    g.neighborhood                                                                                                                                                                                                                                                                                                                                                                                                                                                       geocoder-0.6.0/geocoder/geonames.py                                                                 0000664 0000000 0000000 00000003755 12350734651 0017263 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base


class Geonames(Base):
    name = 'GeoNames'
    url = 'http://api.geonames.org/searchJSON'

    def __init__(self, location, username='addxy'):
        self.location = location
        self.json = dict()
        self.params = dict()
        self.params['q'] = location
        self.params['fuzzy'] = 0.8
        self.params['maxRows'] = 1
        self.params['username'] = username
        if not username:
            self.help_username()

    @property
    def lat(self):
        return self.safe_coord('geonames-lat')

    @property
    def lng(self):
        return self.safe_coord('geonames-lng')

    @property
    def address(self):
        return self.safe_format('geonames-name')

    @property
    def status(self):
        if self.lng:
            return 'OK'
        else:
            msg = self.safe_format('status-message')
            if msg:
                return msg
            else:
                return 'ERROR - No Geometry'

    @property
    def quality(self):
        return self.safe_format('geonames-fcodeName')

    @property
    def state(self):
        return self.safe_format('geonames-adminName1')

    @property
    def country(self):
        return self.safe_format('geonames-countryName')

    @property
    def population(self):
        return self.json.get('geonames-population')

    def help_username(self):
        print '<ERROR>'
        print 'Please provide a <username> paramater when using Geonames'
        print '    >>> import geocoder'
        print '    >>> username = "XXXX"'
        print '    >>> g = geocoder.geonames(<location>, username=username)'
        print ''
        print 'How to get a Username?'
        print '----------------------'
        print 'http://www.geonames.org/login'
        print 'Then, login into your account and enable the free webservices:'
        print 'http://www.geonames.org/enablefreewebservice'

if __name__ =='__main__':
    geonames = Geonames('Ottawa')
    print geonames.bbox
                   geocoder-0.6.0/geocoder/google.py                                                                   0000664 0000000 0000000 00000010146 12350734651 0016731 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base
import hashlib
import urllib
import hmac
import base64
import urlparse


class Google(Base):
    name = 'Google'
    url = 'https://maps.googleapis.com/maps/api/geocode/json'

    def __init__(self, location, short_name=True, client='', secret='', api_key=''):
        self.location = location
        self.short_name = short_name
        self.json = dict()
        self.params = dict()
        self.params['sensor'] = 'false'
        self.params['address'] = location

        # New Encryption for Authentication Google Maps for Business
        if bool(client and secret):
            self.params['client'] = client
            self.params['signature'] = self.get_signature(self.url, self.params, secret)

        # Using old Authentication Google Maps V3
        elif api_key:
            self.params['key'] = api_key

    def get_signature(self, url, params, secret):
        # Convert the URL string to a URL
        params = urllib.urlencode(params)
        url = urlparse.urlparse(url + '?' + params)

        # Signature Key
        urlToSign = url.path + "?" + url.query

        # Decode the private key into its binary format
        decodedKey = base64.urlsafe_b64decode(secret)

        # Create a signature using the private key and the URL-encoded
        # string using HMAC SHA1. This signature will be binary.
        signature = hmac.new(decodedKey, urlToSign, hashlib.sha1)

        # Encode the binary signature into base64 for use within a URL
        encodedSignature = base64.urlsafe_b64encode(signature.digest())
        return encodedSignature

    @property
    def lat(self):
        return self.safe_coord('location-lat')

    @property
    def lng(self):
        return self.safe_coord('location-lng')

    @property
    def status(self):
        return self.safe_format('status')

    @property
    def quality(self):
        return self.safe_format('geometry-location_type')

    @property
    def bbox(self):
        south = self.json.get('southwest-lat')
        west = self.json.get('southwest-lng')
        north = self.json.get('northeast-lat')
        east = self.json.get('northeast-lng')
        return self.safe_bbox(south, west, north, east)

    @property
    def address(self):
        return self.safe_format('results-formatted_address')

    @property
    def postal(self):
        if self.short_name:
            return self.safe_format('postal_code')
        else:
            return self.safe_format('postal_code-long_name')

    @property
    def street_number(self):
        if self.short_name:
            return self.safe_format('street_number')
        else:
            return self.safe_format('street_number-long_name')

    @property
    def route(self):
        if self.short_name:
            return self.safe_format('route')
        else:
            return self.safe_format('route-long_name')

    @property
    def neighborhood(self):
        if self.short_name:
            return self.safe_format('neighborhood')
        else:
            return self.safe_format('neighborhood-long_name')

    @property
    def sublocality(self):
        if self.short_name:
            return self.safe_format('sublocality')
        else:
            return self.safe_format('sublocality-long_name')

    @property
    def locality(self):
        if self.short_name:
            return self.safe_format('locality')
        else:
            return self.safe_format('locality-long_name')

    @property
    def county(self):
        if self.short_name:
            return self.safe_format('administrative_area_level_2')
        else:
            return self.safe_format('administrative_area_level_2-long_name')

    @property
    def state(self):
        if self.short_name:
            return self.safe_format('administrative_area_level_1')
        else:
            return self.safe_format('administrative_area_level_1-long_name')

    @property
    def country(self):
        if self.short_name:
            return self.safe_format('country')
        else:
            return self.safe_format('country-long_name')

if __name__ == '__main__':
    g = Google("Orleans, Ottawa")
    print g.url                                                                                                                                                                                                                                                                                                                                                                                                                          geocoder-0.6.0/geocoder/ip.py                                                                       0000664 0000000 0000000 00000003411 12350734651 0016062 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base


class Ip(Base):
    name = 'IP'

    def __init__(self, location):
        self.location = location
        self.json = dict()
        self.params = dict()
        self.headers = dict()
        self.params['demo'] = 1
        self.headers['Referer'] = 'https://www.maxmind.com/en/geoip_demo'
        self.headers['Host'] = 'www.maxmind.com'
        url = 'https://www.maxmind.com/geoip/v2.0/city_isp_org/{ip}'
        self.url = url.format(ip=self.location)

    @property
    def lat(self):
        return self.safe_coord('location-latitude')

    @property
    def lng(self):
        return self.safe_coord('location-longitude')

    @property
    def address(self):
        city = self.safe_format('city')
        province = self.safe_format('subdivisions')
        country = self.safe_format('country')

        if city:
            return '{0}, {1} {2}'.format(city, province, country)
        elif province:
            return '{0}, {1}'.format(province, country)
        elif country:
            return '{0}'.format(country)
        else:
            return None

    @property
    def quality(self):
        return self.safe_format('traits-domain')

    @property
    def isp(self):
        return self.safe_format('traits-isp')

    @property
    def postal(self):
        return self.safe_format('postal-code')

    @property
    def city(self):
        return self.safe_format('city')

    @property
    def state(self):
        return self.safe_format('subdivisions')

    @property
    def country(self):
        return self.safe_format('country')

    @property
    def ip(self):
        return self.safe_format('traits-ip_address')

if __name__ == '__main__':
    ip = '74.125.226.99'
    results = Ip(ip)
    print results.url                                                                                                                                                                                                                                                       geocoder-0.6.0/geocoder/keys.py                                                                     0000664 0000000 0000000 00000000314 12350734651 0016424 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        bing_key = 'AtnSnX1rEHr3yTUGC3EHkD6Qi3NNB-PABa_F9F8zvLxxvt8A7aYdiG3bGM_PorOq'
tomtom_key = '95kjrqtpzv39ujcxfyr57wz3'
app_id = '6QqTvc3kUWsMjYi7iGRb'
app_code = 'q7R__C774SunvWJDEiWbcA'
username = 'addxy'                                                                                                                                                                                                                                                                                                                    geocoder-0.6.0/geocoder/location.py                                                                 0000664 0000000 0000000 00000004236 12350734651 0017270 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from geocoder import Geocoder
from google import Google


class Location(object):
    """ Location container """

    lat = None
    lng = None
    latlng = None

    def __init__(self, location):
        self.name = location

        # Functions
        self.lat, self.lng = self.check_input(location)
        self.other_format()

    def __repr__(self):
        return '<Location [{0}]>'.format(self.name)

    def other_format(self):
        if bool(self.lat and self.lng):
            self.latlng = self.lat, self.lng

    def convert_float(self, number):
        try:
            return float(number)
        except ValueError:
            print '<ERROR - Input not a number>'
            return None

    def check_input(self, location):
        lat, lng = 0.0, 0.0

        # Checking for a String
        if isinstance(location, str):
            lat, lng = Geocoder(Google(location)).latlng

        # Checking for List of Tuple
        if isinstance(location, (list, tuple)):
            lat, lng = self.check_for_list(location)

        # Checking for Dictionary
        elif isinstance(location, dict):
            lat, lng = self.check_for_dict(location)

        # Checking for a Geocoder Class
        elif hasattr(location, 'latlng'):
            lat, lng = location.latlng

        # Return Results
        return lat, lng

    def check_for_list(self, location):
        # Standard LatLng list or tuple with 2 number values
        if len(location) == 2:
            lat = self.convert_float(location[0])
            lng = self.convert_float(location[1])
            if bool(lat and lng):
                return lat, lng

    def check_for_dict(self, location):
        # Standard LatLng list or tuple with 2 number values
        if bool('lat' in location and 'lng' in location):
            lat = self.convert_float(location.get('lat'))
            lng = self.convert_float(location.get('lng'))
            if bool(lat and lng):
                return lat, lng

if __name__ == '__main__':
    c = {'lat':45.4215296, 'lng':-75.69719309999999}
    b = (45.4215296, -75.69719309999999)
    a = Location(c)
    print a.latlng
    print a.name
    print a

                                                                                                                                                                                                                                                                                                                                                                  geocoder-0.6.0/geocoder/mapquest.py                                                                 0000664 0000000 0000000 00000002235 12350734651 0017314 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base


class Mapquest(Base):
    name = 'MapQuest'
    url = 'http://www.mapquest.ca/_svc/searchio'

    def __init__(self, location):
        self.location = location
        self.json = dict()
        self.params = dict()
        self.params['action'] = 'search'
        self.params['query0'] = location
        self.params['maxResults'] = 1
        self.params['page'] = 0
        self.params['thumbMaps'] = 'false'

    @property
    def lat(self):
        return self.safe_coord('latLng-lat')

    @property
    def lng(self):
        return self.safe_coord('latLng-lng')

    @property
    def address(self):
        return self.safe_format('address-singleLineAddress')

    @property
    def quality(self):
        return self.safe_format('address-quality')

    @property
    def postal(self):
        return self.safe_format('address-postalCode')

    @property
    def locality(self):
        return self.safe_format('address-locality')

    @property
    def state(self):
        return self.safe_format('address-regionLong')

    @property
    def country(self):
        return self.safe_format('address-countryLong')
                                                                                                                                                                                                                                                                                                                                                                   geocoder-0.6.0/geocoder/nokia.py                                                                    0000664 0000000 0000000 00000004336 12350734651 0016562 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base


class Nokia(Base):
    name = 'Nokia'
    url = 'http://geocoder.api.here.com/6.2/geocode.json'

    def __init__(self, location, app_id, app_code):
        self.location = location
        self.json = dict()
        self.params = dict()
        self.params['searchtext'] = location
        self.params['app_id'] = app_id
        self.params['app_code'] = app_code
        self.params['gen'] = 4

        if not bool(app_id and app_code):
            self.help_key()

    @property
    def lat(self):
        return self.safe_coord('NavigationPosition-Latitude')

    @property
    def lng(self):
        return self.safe_coord('NavigationPosition-Longitude')

    @property
    def address(self):
        return self.safe_format('Address-Label')

    @property
    def street_number(self):
        return self.safe_format('Address-HouseNumber')

    @property
    def route(self):
        return self.safe_format('Address-Street')

    @property
    def quality(self):
        return self.safe_format('Result-MatchLevel')

    @property
    def postal(self):
        return self.safe_format('Address-PostalCode')

    @property
    def bbox(self):
        south = self.json.get('BottomRight-Latitude')
        west = self.json.get('TopLeft-Longitude')
        north = self.json.get('TopLeft-Latitude')
        east = self.json.get('BottomRight-Longitude')
        return self.safe_bbox(south, west, north, east)

    @property
    def neighborhood(self):
        return self.safe_format('Address-District')

    @property
    def locality(self):
        return self.safe_format('Address-City')

    @property
    def state(self):
        return self.safe_format('StateName')

    @property
    def country(self):
        return self.safe_format('CountryName')

    def help_key(self):
        print '<ERROR> Please provide both (app_code & app_id) paramaters when using Nokia'
        print '>>> import geocoder'
        print '>>> app_code = "XXXX"'
        print '>>> app_id = "XXXX"'
        print '>>> g = geocoder.nokia(<location>, app_code=app_code, app_id=app_id)'
        print ''
        print 'How to get a Key?'
        print '-----------------'
        print 'http://developer.here.com/get-started'
                                                                                                                                                                                                                                                                                                  geocoder-0.6.0/geocoder/osm.py                                                                      0000664 0000000 0000000 00000003444 12350734651 0016256 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base


class Osm(Base):
    name = 'OSM'
    url = 'http://nominatim.openstreetmap.org/search'

    def __init__(self, location):
        self.location = location
        self.json = dict()
        self.params = dict()
        self.params['format'] = 'json'
        self.params['limit'] = 1
        self.params['addressdetails'] = 1
        self.params['q'] = location

    @property
    def lat(self):
        return self.safe_coord('lat')

    @property
    def lng(self):
        return self.safe_coord('lon')

    @property
    def quality(self):
        return self.safe_format('type')

    @property
    def postal(self):
        postal = self.safe_format('address-postcode')
        if postal:
            return postal
        elif self.address:
            # Using Regular Expressions to get Postal Code from Address
            return self.safe_postal(self.address)

    @property
    def bbox(self):
        south = self.json.get('boundingbox-0')
        west = self.json.get('boundingbox-2')
        north = self.json.get('boundingbox-1')
        east = self.json.get('boundingbox-3')
        return self.safe_bbox(south, west, north, east)

    @property
    def address(self):
        return self.safe_format('display_name')

    @property
    def street_number(self):
        return self.safe_format('address-house_number')

    @property
    def route(self):
        return self.safe_format('address-road')

    @property
    def neighborhood(self):
        return self.safe_format('address-suburb')

    @property
    def locality(self):
        return self.safe_format('address-city')

    @property
    def state(self):
        return self.safe_format('address-state')

    @property
    def country(self):
        return self.safe_format('address-country')
                                                                                                                                                                                                                            geocoder-0.6.0/geocoder/reverse.py                                                                  0000664 0000000 0000000 00000001357 12350734651 0017134 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base
from google import Google
from location import Location


class Reverse(Google, Base):
    name = 'Reverse Google'
    url = 'http://maps.googleapis.com/maps/api/geocode/json'

    def __init__(self, latlng, short_name=True):
        self.location = latlng
        self.short_name = short_name
        self.json = dict()
        self.params = dict()
        lat, lng = Location(latlng).latlng
        self.latlng = '{0},{1}'.format(lat, lng)

        # Parameters for URL request
        self.params['sensor'] = 'false'
        self.params['latlng'] = self.latlng

if __name__ == '__main__':
    latlng = (45.4215296, -75.69719309999999)
    provider = Reverse(latlng)
    print provider.latlng
                                                                                                                                                                                                                                                                                 geocoder-0.6.0/geocoder/tomtom.py                                                                   0000664 0000000 0000000 00000003354 12350734651 0016777 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

from base import Base


class Tomtom(Base):
    name = 'TomTom'
    url = 'https://api.tomtom.com/lbs/geocoding/geocode'

    def __init__(self, location, key):
        self.location = location
        self.json = dict()
        self.params = dict()
        self.params['key'] = key
        self.params['query'] = location
        self.params['format'] = 'json'
        self.params['maxResults'] = 1
        if not key:
            self.help_key()

    @property
    def lat(self):
        return self.safe_coord('geoResult-latitude')

    @property
    def lng(self):
        return self.safe_coord('geoResult-longitude')

    @property
    def street_number(self):
        return self.safe_format('geoResult-houseNumber')

    @property
    def route(self):
        return self.safe_format('geoResult-street')

    @property
    def address(self):
        return self.safe_format('geoResult-formattedAddress')

    @property
    def quality(self):
        return self.safe_format('geoResult-type')

    @property
    def postal(self):
        return self.safe_format('geoResult-postcode')

    @property
    def locality(self):
        return self.safe_format('geoResult-city')

    @property
    def state(self):
        return self.safe_format('geoResult-state')

    @property
    def country(self):
        return self.safe_format('geoResult-country')

    def help_key(self):
        print '<ERROR> Please provide a Key paramater when using TomTom'
        print '>>> import geocoder'
        print '>>> key = "XXXX"'
        print '>>> g = geocoder.tomtom(<location>, key=key)'
        print ''
        print 'How to get a Key?'
        print '-----------------'
        print 'http://developer.tomtom.com/products/geocoding_api'
                                                                                                                                                                                                                                                                                    geocoder-0.6.0/geocoder/utils.py                                                                    0000664 0000000 0000000 00000002270 12350734651 0016614 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

import api
from keys import *
from ip import Ip
from osm import Osm
from bing import Bing
from nokia import Nokia
from arcgis import Arcgis
from tomtom import Tomtom
from google import Google
from reverse import Reverse
from geonames import Geonames
from mapquest import Mapquest
from geocoder import Geocoder

def get_provider(location, provider, short_name):
    provider = provider.lower()

    if provider == 'google':
        return Google(location)
    elif provider == 'bing':
        return Bing(location, key=bing_key)
    elif provider == 'osm':
        return Osm(location)
    elif provider == 'nokia':
        return Nokia(location, app_id=app_id, app_code=app_code)
    elif provider == 'mapquest':
        return Mapquest(location)
    elif provider == 'arcgis':
        return Arcgis(location)
    elif provider == 'ip':
        return Ip(location)
    elif provider == 'reverse':
        return Reverse(location)
    elif provider == 'tomtom':
        return Tomtom(location, key=tomtom_key)
    elif provider == 'geonames':
        return Geonames(location, username=username)

if __name__ == "__main__":
    print get_provider("Ottawa", provider='google')                                                                                                                                                                                                                                                                                                                                        geocoder-0.6.0/requirements.txt                                                                     0000664 0000000 0000000 00000000017 12350734651 0016574 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        requests>=2.3.0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 geocoder-0.6.0/setup.py                                                                             0000664 0000000 0000000 00000003200 12350734651 0015017 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

import os

try:
    from setuptools import setup, find_packages
except ImportError:
    from distutils.core import setup, find_packages

VERSION = '0.6.0'
REQUIRES = ['requests>=2.3.0']

with open('README.md') as f:
    README = f.read()
with open('LICENSE') as f:
    LICENSE = f.read()

setup(
    name='geocoder',
    version=VERSION,
    description="A simplistic Python Geocoder (Google, Bing, OSM & more)",
    long_description=README,
    author='Denis Carriere',
    author_email='carriere.denis@gmail.com',
    url='https://github.com/DenisCarriere/geocoder',
    download_url='https://github.com/DenisCarriere/geocoder/tarball/master',
    license=LICENSE,
    packages=['geocoder'],
    package_data={'': ['LICENSE', 'README.md']},
    package_dir={'geocoder': 'geocoder'},
    include_package_data=True,
    install_requires=REQUIRES,
    zip_safe=False,
    keywords='geocoder google lat lng location addxy',
    classifiers=(
        'Development Status :: 5 - Production/Stable',
        'Intended Audience :: Developers',
        'Intended Audience :: Science/Research',
        'License :: OSI Approved :: Apache Software License',
        'Natural Language :: English',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3.2',
        'Programming Language :: Python :: 3.3',
        'Topic :: Internet',
        'Topic :: Internet :: WWW/HTTP',
        'Topic :: Scientific/Engineering :: GIS',
        'Topic :: Software Development :: Libraries :: Python Modules'
    ),
)
                                                                                                                                                                                                                                                                                                                                                                                                geocoder-0.6.0/test_geocoder.py                                                                     0000664 0000000 0000000 00000002374 12350734651 0016520 0                                                                                                    ustar 00root                            root                            0000000 0000000                                                                                                                                                                        #!/usr/bin/python
# coding: utf8

import geocoder
import pytest
import unittest

location = 'Ottawa, ON, Canada'
ip = '74.125.226.99'
repeat = 3
ottawa = (45.4215296, -75.6971930)
toronto = (43.653226, -79.3831843)

def test_entry_points():
    geocoder.ip
    geocoder.get
    geocoder.osm
    geocoder.bing
    geocoder.nokia
    geocoder.google
    geocoder.arcgis
    geocoder.tomtom
    geocoder.reverse
    geocoder.geonames
    geocoder.mapquest
    geocoder.population

def test_google():
    g = geocoder.google(location)
    assert g.ok

def test_bing():
    g = geocoder.bing(location)
    assert g.ok

def test_nokia():
    g = geocoder.nokia(location)
    assert g.ok

def test_osm():
    g = geocoder.osm(location)
    assert g.ok

def test_tomtom():
    g = geocoder.tomtom(location)
    assert g.ok

def test_mapquest():
    g = geocoder.mapquest(location)
    assert g.ok

def test_geonames():
    g = geocoder.geonames(location)
    assert g.ok

def test_reverse():
    g = geocoder.reverse(ottawa)
    assert g.ok

def test_ip():
    g = geocoder.ip(ip)
    assert g.ok

def test_get():
    g = geocoder.get(location)
    assert g.ok

"""
Not Currently working
ArcGIS server are down

def test_arcgis():
    g = geocoder.arcgis(location)
    assert g.ok
"""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    