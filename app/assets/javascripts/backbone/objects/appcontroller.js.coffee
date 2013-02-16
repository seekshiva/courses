jQuery ->
  class AppController extends Backbone.Model
    initialize: (options={}) =>
      console.log "init AppController"
      @app = window.app ? {}

      @MODELS_DEF =
        "department_model": @app.DepartmentModel
        "course_model": @app.InterviewerModel

      @COLLECTIONS_DEF =
        "departments_collection": @app.DepartmentsCollection
        "courses_collection": @app.CoursesCollection
        "a_collection": @app.IntervieweesCollection
      @

    setData: (key, value) ->
      if @persistant_data == undefined
        @persistant_data = {}

      if @persistant_data[key] == undefined
        @trigger("persistant:set:#{key}")

      @trigger("persistant:change:#{key}")
      @persistant_data[key] = value

    getData: (key) ->
      if @persistant_data and @persistant_data[key]
        return @persistant_data[key]
      else
        return undefined

    setModel: (data, key, uid=null) ->
      def_key = key
      if uid
        key = "#{key}-#{uid}"

      if not @MODELS_DEF[def_key]
        console.log "HR Error: Model with key `#{key}` doesn't exist"

      if not @MODELS
        @MODELS = {}

      if not @MODELS[key]
        @MODELS[key] = new @MODELS_DEF[def_key]()

      @MODELS[key].set(data)

    getModel: (key, uid=null, callback=null, fetch=true) ->
      def_key = key
      if uid
        key = "#{key}-#{uid}"

      if callback == null
        callback = (model) ->
          return undefined

      if not @MODELS_DEF[def_key]
        console.log "HR Error: Model with key `#{key}` doesn't exist"

      if not @MODELS
        @MODELS = {}

      if not @MODELS[key]
        @MODELS[key] = new @MODELS_DEF[def_key]
        callback(@MODELS[key])

      if fetch
        @MODELS[key].fetch
          casual: true

      return @MODELS[key]

    cleanModelCache: (keyPrefix) ->
      that = @
      _.each @MODELS, (o, key)->
        if key.indexOf(keyPrefix) == 0
          delete(that.MODELS[key])

    setCollection: (data, key, uid=null) ->
      def_key = key
      if uid
        key = "#{key}-#{uid}"

      if not @COLLECTIONS_DEF[def_key]
        console.log "HR Error: Collection with key `#{key}` doesn't exist"
        return {}

      if not @COLLECTIONS
        @COLLECTIONS = {}

      if not @COLLECTIONS[key]
        @COLLECTIONS[key] = new @COLLECTIONS_DEF[def_key]()

      @COLLECTIONS[key].reset(data, {silent: false})


    getCollection: (key=null, uid=null, callback=null, fetch=true, force_fetch=false) ->
      def_key = key
      if uid
        key = "#{key}-#{uid}"

      if callback == null
        callback = (collection) ->
          return undefined

      if not @COLLECTIONS_DEF[def_key]
        console.log "HR Error: Collection with key `#{key}` doesn't exist"
        return {}

      if not @COLLECTIONS
        @COLLECTIONS = {}

      if not @COLLECTIONS[key]
        @COLLECTIONS[key] = new @COLLECTIONS_DEF[def_key]
        callback(@COLLECTIONS[key])

      if fetch
        @COLLECTIONS[key].fetch
          casual: !force_fetch

      return @COLLECTIONS[key]

    cleanCollectionCache: (keyPrefix) ->
      that = @
      _.each @COLLECTIONS, (o, key)->
        if key.indexOf(keyPrefix) == 0
          delete(that.COLLECTIONS[key])

  @app = window.app ? {}
  @app.AppController = AppController
  @