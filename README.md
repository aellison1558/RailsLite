# RailsLite with ActiveRecordLite

A Web server MVC framework inspired by the functionality of Ruby on Rails

Comes with my ActiveRecordLite, which builds model classes connected to tables in a relational database.

[Example Project][example]
[example]: https://github.com/aellison1558/RailsLiteTODOApp

To use:

- Fill in SQL file (sql_file.sql) with desired tables.

- Create appropriate models, controllers, and views in provided folders

  - Models must have require_relative('./active_record_base') at top

  - Controllers must have require_relative('./controller_base') and must also require the associated model

  - Views must be placed in a folder within views named after their controller, ex: "examples_controller"

- Write routes in app.rb within router.draw block

  - app.rb must require all controller files in order to connect routes with controller actions

- From command line in directory, run 'ruby app.rb' to begin server
- Navigate to Localhost:3000 in browser to see site
