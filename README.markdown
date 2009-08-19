VistA Adapter
=============

This is a [JRuby](http://www.jruby.org/) based set of objects to work with [OpenVista](http://medsphere.org/community/project/openvista-server), 
an electronic health record system based on [VA VistA](http://vistapedia.net/index.php?title=What_is_VistA_Really). It uses [OVID](http://medsphere.org/community/project/ovid)
to access data in VistA and provides Ruby objects for working with patients, medications, vital signs, etc.

ActiveFileMan
-------------

This project contains a very small framework called ActiveFileMan that provides access to files in VistA FileMan in a similar fashion to ActiveRecord providing access to tables in an RDBMS.

Building
--------

    rake gem

Configuring
-----------

Change the config/vista.yml file to point to your VistA installation

Running
-------

    patient = Patient.find_by_ien('1')
    patient.name # => "PATIENT NAME"

License
-------

Copyright 2009 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.