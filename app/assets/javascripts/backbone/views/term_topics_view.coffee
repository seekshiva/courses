jQuery ->
  class TermTopicsView extends Backbone.View
    el: "#specialized_view"
    template: Handlebars.compile($("#term-topics-template").html())
    topic_template: Handlebars.compile($("#topic-template").html())
    events:
      "click #ct_status_selector > .btn": "updateSelector"
      "click .row > .list-group > .list-group-item": "updateCurrentSection"
      "click .delete_section" : "deleteSection"
      "click .delete_topic" : "deleteTopic"
      "click #create_section" : "createSection"
      "click .create_topic" : "createTopic"
      "click .toggle_edit_section" : "toggleSectionEdit"
      "click .toggle_edit_topic" : "toggleTopicEdit"
      "click .edit_section" : "updateSection"
      "click .edit_topic" : "updateTopic"
      "click .ct_select_btn.input-group-btn li" : "updateCTSelection"
      
    selectors:
      ct_status:
        "ct1": false
        "ct2": false
        "postct": false
    
    createSection: (e) ->
      e.preventDefault()
      title = $.trim($("#new_section_title").val())
      $("#new_section_title").val("")
      if title != ""
        section = new @term_view.app.SectionModel
          title   : title
          term_id : @term_view.term.id
        that = @
        section.save(null, {success: (model, resp) ->
          that.term_view.term.attributes.sections.push(section.attributes)
          that.render()
        })
      @

    createTopic: (e) ->
      e.preventDefault()
      section_id = $(e.target).attr("section-id").toString()
      topic_title = $.trim($("#topic_title_"+section_id).val())
      topic_ct = $.trim($("#topic_ct_"+section_id).val())
      topic_description = $.trim($("#topic_description_"+section_id).val())
      if topic_title != ""
        topic = new @term_view.app.TopicModel({
          title:          topic_title,
          ct_status:      topic_ct,
          description:    topic_description,
          section_id:     parseInt(section_id)
        })
        that = this
        topic.save null, success: (model, resp) ->
          term = that.term_view.term
          elem = _.find term.attributes.sections, (obj) ->
            return obj.id.toString() == section_id
          elem.topics.push(topic.attributes)
          that.render()
      @
    
    toggleSectionEdit: (e) ->
      e.preventDefault()
      section_id = $(e.target).attr("section-id") || $(e.target).parent().attr("section-id")
      if @section_id == section_id
        @section_id = null
      else
        @section_id = section_id
      @topic_id = null
      @render()
      @

    updateSection: (e) ->
      e.preventDefault()
      section_id = $(e.target).attr("section-id") || $(e.target).parent().attr("section-id")
      title = $.trim($("#section_title_"+section_id).val())
      if title != ""
        section = new @term_view.app.SectionModel({id: section_id, title: title})
        that = this
        section.save null, success: (model, resp) ->
          term_attributes = that.term_view.term.attributes
          elem = _.find term_attributes.sections, (obj) ->
            return obj.id.toString() == section_id.toString()
          elem.title = title
          that.section_id = null
          that.render()

      @

    toggleTopicEdit: (e) ->
      e.preventDefault()
      topic_id = $(e.target).attr("topic-id") || $(e.target).parent().attr("topic-id")
      if @topic_id == topic_id
        @topic_id = null
      else
        @topic_id = topic_id
      @section_id = null
      @render()
      @
      
    updateTopic: (e) ->
      e.preventDefault()
      topic_id = $(e.target).attr("topic-id") || $(e.target).parent().attr("topic-id")
      title = $.trim($("#topic_title_"+topic_id).val())
      ct_status = $.trim($("#topic_ct_"+topic_id).val())
      description = $.trim($("#topic_description_"+topic_id).val())
      topic_reference = $(".topic_reference")
      topic_notes = $("#topic_notes_"+topic_id).val()

      for section in @term_view.term.attributes.sections
        topic = _.find section.topics, (topic) ->
          return topic.id.toString() == topic_id.toString()
        if topic
          for note in topic.notes
            sub = -1
            if topic_notes!=null && note && note.note_id
              sub = topic_notes.indexOf(note.note_id.toString())
            if note && note.id && sub==-1
              # Delete topic_notes
              topic_note_model = new @term_view.app.TopicDocumentModel
                id: note.id
              topic_note_model.destroy()
              index = topic.notes.indexOf(note)
              topic.notes.splice(index, 1)
              @render()
            else if sub!=-1 && note.id==null
              # Create topic_notes
              topic_note_model = new @term_view.app.TopicDocumentModel
                note_id:   note.note_id
                url:       note.url
                name:      note.name
                topic_id:  topic_id
              that = this
              topic_note_model.save(null, { success: (model, resp) ->
                for section in that.term_view.term.attributes.sections
                  topic = _.find section.topics, (topic) ->
                    return topic.id.toString() == topic_id.toString()
                  if topic
                    topic.notes.push
                      id: topic_note_model.id,
                      note_id: topic_note_model.attributes.note_id,
                      url: topic_note_model.attributes.url,
                      name: topic_note_model.attributes.name,
                    break
              })

      for topic_ref in topic_reference
        ref_id = $(topic_ref).attr("ref-id")
        term_ref_id = $(topic_ref).attr("term-ref-id")
        book_id = $(topic_ref).attr("book-id")
        book = $(topic_ref).attr("book-name")
        indices = $.trim($(topic_ref).val())
        if ref_id
          ref = new @term_view.app.TopicReferenceModel
            term_reference_id: term_ref_id
            topic_id: topic_id
            indices: indices
            id: ref_id
            book_id: book_id
            book: book
          that = this
          if indices == ""
            ref.destroy()
            for section in that.term_view.term.attributes.sections
              elem = _.find section.topics, (topic) ->
                return topic.id.toString() == topic_id.toString()
              if elem
                refs = _.find elem.reference, (ref) ->
                  return ref.id.toString() == ref_id.toString()
                index = elem.reference.indexOf(refs)
                elem.reference.splice(index, 1)
                that.render()
                break
          else
            ref.save(null, { success: (model, resp) ->
              for section in that.term_view.term.attributes.sections
                elem = _.find section.topics, (topic) ->
                  return topic.id.toString() == topic_id.toString()
                if elem
                  elem = _.find elem.reference, (elem) ->
                    return elem.id.toString() == ref.id.toString()
                  elem.indices = ref.attributes.indices
                  that.render()
                  break
            })
        else
          if indices != ""
            ref = new @term_view.app.TopicReferenceModel({term_reference_id: term_ref_id, topic_id: topic_id, indices: indices, book_id: book_id, book: book})
            that = this
            ref.save(null, { success: (model, resp) ->
              term_attributes = that.term_view.term.attributes
              book = _.find term_attributes.course.reference_books, (elem) ->
                return elem.id == ref.attributes.book_id

              for section in that.term_view.term.attributes.sections
                elem = _.find section.topics, (topic) ->
                  return topic.id.toString() == topic_id.toString()
                if elem
                  elem.reference.push
                    id: ref.id,
                    book_id: ref.attributes.book_id,
                    indices: ref.attributes.indices,
                    book: ref.attributes.book,
                    term_ref_id: ref.attributes.term_reference_id
                  that.render()
                  break
            })

      if title != ""
        topic = new @term_view.app.TopicModel({id: topic_id, title: title, ct_status: ct_status, description: description})
        that = this
        topic.save null, success: (model, resp) ->
          for section in that.term_view.term.attributes.sections
            elem = _.find section.topics, (topic) ->
              return topic.id.toString() == topic_id.toString()
            if elem
              elem.title = title
              elem.ct_status = ct_status
              elem.description = description
              break
          that.topic_id = null
          that.render()

      @
      
    deleteSection: (e) ->
      e.preventDefault()
      unless confirm("Are you sure you want to delete this?")
        return
      section_id = $(e.target).attr("section-id") || $(e.target).parent().attr("section-id")
      section = new @term_view.app.SectionModel({id : section_id})
      section.destroy()
      elem = _.find @term_view.term.attributes.sections, (obj) ->
        return obj.id.toString() == section_id.toString()
      index = @term_view.term.attributes.sections.indexOf(elem)
      @term_view.term.attributes.sections.splice(index, 1)
      @render()
      @

    deleteTopic: (e) ->
      e.preventDefault()
      unless confirm("Are you sure you want to delete this?")
        return
      topic_id = $(e.target).attr("topic-id") || $(e.target).parent().attr("topic-id")
      topic = new @term_view.app.TopicModel({id: topic_id})
      topic.destroy()
      for section in @term_view.term.attributes.sections
        elem = _.find section.topics, (topic) ->
          return topic.id.toString() == topic_id.toString()
        if elem
          topic_index = section.topics.indexOf(elem)
          section_index = @term_view.term.attributes.sections.indexOf(section)
          @term_view.term.attributes.sections[section_index].topics.splice(topic_index, 1)
          break
      @render()
      @

    updateCTSelection: (e)->
      e.preventDefault()
      val = $(e.target).text()
      btn = $(e.target).closest(".ct_select_btn")
      $(btn).find("button > span").text(val)
      $(btn).siblings("[type=hidden]").val(val)
      @

    updateSelector: (e)->
      if e and e.target
        e.preventDefault()
        timeframe = $(e.target).text().trim().toLowerCase().replace(" ", "")
        @selectors.ct_status[timeframe] = not @selectors.ct_status[timeframe]
        @render()
      @
    
    render: (term_view) =>
      @app = window.app ? {}
      if term_view and term_view instanceof @app.TermView
        @term_view = term_view

      search_text = $("#search_box").val()
      if search_text
        search_text.replace(/^\s*/g, '')
      search_regx = new RegExp(search_text, "i")
      current_topic = 0

      @term_sections = []
      flag = true
      for section in @term_view.term.attributes.sections
        section_clone = Object.create(section)
        if @section_id
          if @section_id.toString() == section.id.toString()
            section_clone["edit"] = true
          else
            section_clone["edit"] = false
        section_clone["topics"] = []
        for topic in section.topics
          topic["edit"] = false
          books = _.filter topic["reference"], (ele) ->
            return $.trim(ele.indices) != ""

          notes = _.filter topic["notes"], (ele) ->
            return ele.id != null

          topic["reference"] = books
          topic["notes"] = notes
          if @topic_id
            if @topic_id.toString() == topic.id.toString()
              topic["edit"] = true
              delete topic["ct_select"]
              status = topic.ct_status.toString().replace(" ","")
              topic["ct_select"] = {}
              topic["ct_select"][status] = true
              books = []
              for book in @term_view.term.attributes.course.reference_books
                ref_book = _.find topic["reference"], (ele) ->
                  return ele.book_id.toString() == book.id.toString()

                if ref_book
                  books.push
                    id:           ref_book.id,
                    book_id:      ref_book.book_id,
                    indices:      ref_book.indices,
                    book:         ref_book.book,
                    term_ref_id:  book.term_ref_id
                else
                  books.push
                    book_id:        book.id,
                    indices:        "",
                    book:           book.title,
                    term_ref_id:    book.term_ref_id

              topic["reference"] = books
              notes = []
              for note in @term_view.term.attributes.attachments
                ref_note = _.find(topic["notes"], (ele) ->
                  return ele.note_id.toString() == note.id.toString()
                )
                if ref_note
                  notes.push
                    id:       ref_note.id
                    note_id:  ref_note.note_id
                    name:     ref_note.name
                    url:      ref_note.url
                else
                  notes.push
                    id:       null
                    note_id:  note.id
                    name:     note.name
                    url:      note.url

              topic["notes"] = notes

          no_filter = not (@selectors.ct_status["ct1"] || @selectors.ct_status["ct2"] || @selectors.ct_status["postct"])

          if no_filter or @selectors.ct_status[topic.ct_status.toLowerCase().replace(" ", "")]
            if search_text == "" || (topic.title && topic.title.search(search_regx) != -1) || (topic.description && topic.description.search(search_regx) != -1)
              section_clone.topics.push topic

        if section_clone.topics.length or @term_view.view.id == "edit"
          @term_sections.push(section_clone)
          if section_clone.id == @current_section_id
            section_clone.active = true
            flag = false
          else
            section_clone.active = false

      edit_mode = ""
      if @term_view.view.id == "edit" && @term_view.term.attributes.faculty == true
        edit_mode = "edit_mode"

      that =
        term_topics: @
        faculty: @term_view.term.attributes.faculty
        
        
      Handlebars.registerHelper "show_topic",  ->
        that.term_topics.topic_template
          topic: @
          faculty: that.faculty
          edit_mode: edit_mode

      $(@el).html @template
        term:            @term_view.term.attributes
        topic_template:  @topic_template
        edit_mode:       edit_mode
        term_sections:   @term_sections
        selectors:       @selectors
        show_all:        flag
        faculty:         @term_view.term.attributes.faculty
        host:            window.location.host

      $(".selectpicker").selectpicker()

      if search_text != "" && search_text
        $("#search_box").focus().val(search_text)
      $("#search_box").bind("input", _.bind(@render,@))
      @

    updateCurrentSection: (e) =>
      hash = $(e.target).closest("a")[0].hash
      if hash == "#_all_sections"
        @current_section_id = -1
      else
        @current_section_id = +hash.substr(10)

  @app = window.app ? {}
  @app.TermTopicsView = TermTopicsView
