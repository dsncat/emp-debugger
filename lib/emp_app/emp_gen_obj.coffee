
module.exports =
class GenObj
  len:null
  ulen:null
  obj_list:null
  unused:null

  constructor: (obj_list)->
    @len = 0
    @obj_list = {}
    @unused = {}

    for obj in obj_list
      @obj_list[obj.id] = obj
      @unused[obj.id] = obj
      @len += 1

    @ulen = @len


  put: (obj)->
    if !@obj_list[obj.id]
      @obj_list[obj.id] = obj
      @len += 1

    if !@unused[obj.id]
      @unused[obj.id] = obj
      @ulen += 1

  refresh:(obj) ->
    if @obj_list[obj.id]
      @obj_list[obj.id] = obj
    if @unused[obj.id]
      @unused[obj.id] = obj

  delete:(col_id) ->
    if @obj_list[col_id]
      delete @obj_list[col_id]
      @len -= 1
    if @unused[col_id]
      delete @unused[col_id]
      @ulen -= 1


  check_exist:(obj) ->
    if !@obj_list[obj.id]
      @obj_list[obj.id] = obj
      @len += 1
      @unused[obj.id] = obj
      @ulen += 1
      false
    else
      true

  get: (id) ->
    @obj_list[id]

  use: (id) ->
    re = @obj_list[id]

    unless !re
      @set_used(id)
    re

  set_used: (id) ->
    unless !@unused[id]
      delete @unused[id]
      @ulen -= 1


  get_all: ->
    @obj_list

  get_unused: () ->
    @unused
