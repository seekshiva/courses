jQuery ->
  class DepartmentModel extends Backbone.Model
    paramRoot: 'department'

    defaults:
      name:          null
      hod:           null
      short:         null
      rollno_prefix: null
      terms:         null

    urlRoot: "/departments/"

  class DepartmentsCollection extends Backbone.Collection
    model: DepartmentModel
    url: "/departments/"

  class CourseModel extends Backbone.Model
    paramRoot: 'course'

    defaults:
      name:        null
      credits:     null
      about:       null
      latest_term: null
      topics:      null

    urlRoot: "/courses/"

  class TermModel extends Backbone.Model
    paramRoot: 'term'

    defaults:
      name:        null
      credits:     null
      about:       null
      latest_term: null
      topics:      null

    urlRoot: "/terms/"

   
  @app                       = window.app ? {}
  @app.DepartmentModel       = DepartmentModel
  @app.CourseModel           = CourseModel
  @app.TermModel             = TermModel
  @app.DepartmentsCollection = DepartmentsCollection
