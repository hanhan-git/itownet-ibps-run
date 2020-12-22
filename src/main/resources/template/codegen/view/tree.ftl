<template>
  <ibps-layout ref="layout">
    <div slot="west">
      <ibps-tree
        ref="tree"
        :width="width"
        :height="height"
        :data="${classVar}TreeData"
        :options="${classVar}Treeoptions"
        :contextmenus="${classVar}TreeContextmenus"
        title="${comment}管理"
        @action-event="handleTreeAction"
        @node-click="handleNodeClick"
        @expand-collapse="handleExpandCollapse"
      />
      <ibps-container
        :margin-left="width+'px'"
        class="page"
      >
        <edit
          v-if="show==='edit'"
          :id="${classVar}Pk"
          :parent-id="parentId"
          :readonly="readonly"
          @callback="loadTreeData"
        />

        <el-alert
          v-else
          :closable="false"
          title="尚未指定一个${comment}"
          type="warning"
          show-icon
          style="height:50px;"
        />
      </ibps-container>

    </div>
  </ibps-layout>
</template>
<script>
import { remove, getTreeData } from '@/api/${sys}/${module}/${classVar}'
import ActionUtils from '@/utils/action'
import FixHeight from '@/mixins/height'
import Edit from './tree-edit'

export default {
  components: {
    Edit
  },
  mixins: [FixHeight],
  data() {
    return {
      show: '',
      width: 230,
      height: document.clientHeight,
      readonly: false,
      ${classVar}Pk: '',

      // ${comment}树配置
      ${classVar}Treeoptions: {
        nodeKey: '${convertUnderLine(model.variables.idKey)}',
        pidKey: '${convertUnderLine(model.variables.pidKey)}',
        props: {
          label: '${convertUnderLine(model.variables.key)}'
        }
      },
      ${classVar}TreeContextmenus: [
        { icon: 'add', label: '添加', value: 'add' },
        { icon: 'edit', label: '编辑', value: 'edit', rights: ['node'] },
        { icon: 'remove', label: '删除', value: 'remove', rights: ['node'] }
      ],
      ${classVar}TreeData: []
    }
  },
  created() {
    this.loadTreeData()
  },
  methods: {
    handleTreeAction(command, position, selection, data) {
      if (position === 'toolbar') {
        if (command === 'refresh') {
          this.loadTreeData()
        }
      } else {
        const id = data.${convertUnderLine(model.variables.idKey)}
        switch (command) {
          case 'add':// 添加
            this.handleEdit('', id)
            break
          case 'edit':// 编辑
            this.handleEdit(id)
            break
          case 'remove':// 删除
            ActionUtils.removeRecord(id).then((ids) => {
              this.handleRemove(ids)
            }).catch(() => { })
            break
          default:
            break
        }
      }
    },
    // 添加 编辑
    handleEdit(id = '', parentId) {
      this.show = 'edit'
      this.readonly = false
      this.${classVar}Pk = id
      this.parentId = parentId
    },
    // 处理删除
    handleRemove(ids) {
      remove({ ids: ids }).then(response => {
        ActionUtils.removeSuccessMessage()
        this.loadTreeData()
      }).catch(() => {})
    },
    // 树点击
    handleNodeClick(data) {
      if (data.${convertUnderLine(model.variables.idKey)} === 0 || data.${convertUnderLine(model.variables.idKey)} === '0') {
        this.show = 'empty'
        return
      }
      this.readonly = true
      this.${classVar}Pk = data.${convertUnderLine(model.variables.idKey)} + ''
      this.parentId = data.${convertUnderLine(model.variables.pidKey)} + ''
      this.show = 'edit'
    },
    handleExpandCollapse(isExpand) {
      this.width = isExpand ? 230 : 30
    },
    loadTreeData() {
      getTreeData({
        parameters: [],
        requestPage: {},
        sorts: []
      }).then(response => {
        const data = response.data
        this.${classVar}TreeData = data
      }).catch(() => {
      })
    },
    // 查询
    search() {
      this.loadTreeData()
    }
  }
}
</script>


