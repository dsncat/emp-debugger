{$, $$, View} = require 'atom'
path = require 'path'
EmpEditView = require '../../view/emp-edit-view'
emp = require '../../exports/emp'
AdapterView = require './cha_adapter_view'
ParamView = require './cha_params_view'
channel = require '../emp_item/channel'

module.exports =
class AddGenPanel extends View
  name:emp.ADD_CHA_VIEW
  cha_obj:null
  adapter_view :null
  params_view:null
  active_view:null
  is_edit:false

  @content: ()->

    @div class: 'general-panel section', =>
      @div outlet: "loadingElement", class: 'alert alert-info loading-area icon icon-hourglass', "Loading settings"
      @div class: 'add-channel-panel', =>
        # @section class: 'config-section', =>
        @div class: 'block section-heading icon icon-gear', "Create A Channel..."
        @div class: 'div-body', =>
          @div class:'div-con ', =>
            @div class:'cha_detail_div', =>
              @div class: 'info-div', =>
                @label outlet:"cha_id_title",class: 'info-label', '频道ID*: '
                @subview "cha_id", new EmpEditView(attributes: {id: 'cha_id', type: 'string'},  placeholderText: 'Channel ID') #from editor view class
              @div class: 'info-div', =>
                @label class: 'info-label', '频道名称*'
                @subview "cha_name", new EmpEditView(attributes: {id: 'cha_name', type: 'string'},  placeholderText: 'Channel Name') #from editor view class
              @div class: 'info-div', =>
                @label class: 'info-label', '所属App'
                @subview "cha_app", new EmpEditView(attributes: {id: 'cha_app', type: 'string'},  placeholderText: 'App') #from editor view class
            @div class: 'info-div', =>
              @label class: 'info-label', '频道配型'
              @select outlet: "channel_entry", class: "form-control", =>
                @option value: emp.CHANNEL_ADAPTER, selected:"selected", "适配"
                @option value: emp.CHANNEL_NEW_CALLBACK, "新回调"
            @div outlet:'cha_state_info', class: 'info-div info-font', =>
              @label class: 'info-label', '频道状态:'
              # @div class: 'checkbox', =>
              @input outlet:'cha_state', type: 'checkbox', checked:'true'
              @text "开启"

            # @div outlet:'entry_params', class:'entry_div'

            @div outlet:'cha_params', class:'cha_parma_div'

        @div class: 'item_div', =>
          @div class: 'item_cbtn_div', =>
            @button class: 'item_btn btn btn-info inline-block-tight', click:'do_cancel','  Cancel  '
            @button class: 'item_btn btn btn-info inline-block-tight', click:'do_submit',' Ok '

  initialize: (@fa_view, extra_param)->
    @cha_obj = new channel()
    if extra_param
      console.log "edit channel"
      console.log extra_param
      @is_edit = true
      @cha_id.hide()
      @cha_id_title.after(@new_id_label(extra_param.id))
      @cha_name.getEditor().setText(extra_param.name)
      @cha_app.getEditor().setText(extra_param.app)
      # @cha_name.getEditor().setText(extra_param.name)
      if extra_param.entry is emp.CHANNEL_NEW_CALLBACK
        @channel_entry.val(emp.CHANNEL_NEW_CALLBACK)
      else
        @channel_entry.val(emp.CHANNEL_ADAPTER)
      if !extra_param.state
        @cha_state.prop('checked', false)

    @adapter_view = new AdapterView(@cha_obj)
    @params_view = new ParamView(@cha_obj)
    @cha_state_info.after(@adapter_view)
    @cha_params.append(@params_view)
    @loadingElement.remove()
    @active_view = @adapter_view
    @cha_id.getEditor().on 'contents-modified', =>
      @cha_obj.id = @cha_id.getEditor().getText().trim()


  new_id_label: (tmp_id)->
    $$ ->
      @label class: 'info-label', "#{tmp_id}"

  # Tear down any state and detach
  destroy: ->
    @detach()

  focus: ->
    @cha_id.focus()

  do_cancel:  ->
    @fa_view.show_panel(emp.GEN_VIEW)
    @destroy()


  do_submit: ->
    tmp_id = @cha_id.getEditor().getText().trim()
    tmp_name = @cha_name.getEditor().getText().trim()
    tmp_app = @cha_app.getEditor().getText().trim()
    # console.log "id:#{tmp_id}, name:#{tmp_name}, app:#{tmp_app}"
    # console.log "s:#{tmp_state}, e:#{tmp_entry}"

    try


      unless tmp_id
        throw("频道Id不能为空！")
      unless tmp_name
        throw("频道Name不能为空！")
      unless tmp_app
        throw("频道所属App不能为空！")
      tmp_entry = @channel_entry.val()
      tmp_state = @cha_state.prop('checked')
      @cha_obj.id = tmp_id
      @cha_obj.app = tmp_app
      @cha_obj.name = tmp_name
      @cha_obj.set_entry(tmp_entry)
      @cha_obj.set_state(tmp_state)

      @active_view.submit_detail()
      @params_view.submit_detail()

      if !@is_edit

        @do_add()
        @fa_view.after_add_channel(@cha_obj)
      else
        @do_edit()
        @fa_view.after_edit_channel(@cha_obj)

      @destroy()

    catch e
      console.log e
      emp.show_error(e)

  do_add: ->
    console.log "do add"
    cha_objs = @fa_view.all_objs.cha.obj_list
    tmp_id = @cha_obj.id
    if cha_objs[tmp_id]
      throw("该channel 已经存在~")

    @cha_obj.create_channel(@fa_view.all_objs.cha.len)
    emp.show_info("添加 channel 完成~")
    # console.log __dirname
    # path.join __dirname,
    # console.log @all_objs
    # console.log @fa_view.all_objs
    # console.log @cha_obj

  do_edit: ->
    @cha_obj.edit_channel(@fa_view.all_objs.cha.len)
    emp.show_info("修改 channel 完成~")
