jQuery ->
  class DepartmentModel extends Backbone.Model
    paramRoot: 'department'

    defaults:
      name: null
      hod: null
      short: null
      courses: null

    urlRoot: "/departments/"

  class DepartmentsCollection extends Backbone.Collection
    model: DepartmentModel
    url: "/departments/"

   
  @app = window.app ? {}
  @app.DepartmentModel = DepartmentModel
  @app.DepartmentsCollection = DepartmentsCollection
