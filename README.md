Cucure
======

Cucumber/Watir BDD refactoring tool

This script parses your Cucumber/Watir tests and find unused steps and accessors allowing you to maintain a clean code.


Usage
======

The script search in the following folders: 
- Steps definition:  ./features/step_definitions/
- Steps in features:  ./features/web/

You can specify the next parameters:

<-V> : Shows script version  
<-F> : Specify base folder

Example:

    ruby cucure -F./myworkspace/tests/suite1
    

TODO
======

- Find unused accessors
- Find repeated steps
- Find repeated accesors by file
