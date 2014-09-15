{$, View} = require 'atom'
emp = require '../../exports/emp'

module.exports =
class ChaItemView extends View
  cha_obj:null
  cha_name:null
  cha_id:null
  isSelected:false
  @content: (@cha_obj)->
    @cha_name = @cha_obj.name
    @cha_id = @cha_obj.id

    @li class: 'list-item' , =>
      @div outlet: 'cha_item', id:@cha_id, class: 'emp_cha_item_tag list-item', =>
        @span outlet: 'chaName', class: 'text-success icon  icon-diff-modified', 'data-name':"*.json", @cha_name

  initialize: (obj)->
    this

  select: ->
    if !@isSelected
      @addClass('selected')
      @chaName.removeClass('text-success').addClass('text-highlight')
      @isSelected = true

  deselect: ->
    if @isSelected
      @removeClass('selected')
      @chaName.removeClass('text-highlight').addClass('text-success')
      @isSelected=false
