<template>
  <div>
    <div v-if="readonly">
      <el-form :label-width="formLabelWidth">
	<#list commonList as col>
	<#assign colName=col.colName>
        <el-form-item label="${col.comment}:" prop="${colName}">
          <span>{{ form.${colName} }}</span>
        </el-form-item>
	</#list>  
      </el-form>
    </div>
    <ibps-container v-else type="full" header-background-color class="page">
      <template slot="header">
        <el-button type="primary" icon="ibps-icon-save" @click="handleSave()">保存</el-button>
      </template>
      <el-form ref="${classVar}Form" :model="form" :rules="rules" :label-width="formLabelWidth">
	<#list commonList as col>
	<#assign colName=col.colName>
        <el-form-item label="${col.comment}:" prop="${colName}">
          <el-input v-model="form.${colName}"/>
        </el-form-item>
	</#list>  
      </el-form>
    </ibps-container>
  </div>
</template>
<script>
import { save, get } from '@/api/${sys}/${module}/${classVar}'
import ActionUtils from '@/utils/action'
// import { validateKey, validateEmpty } from '@/utils/validate'

export default {
  props: {
    id: [String, Number],
    parentId: [String, Number],
    readonly: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      formName: '${classVar}Form',
      formLoading: false,
      formLabelWidth: '120px',
      formId: '',
      clientHeight: '',
      optionsWidth: '',
      defaultForm: {},
      form: {
		<#list colList as col>
        ${col.colName}: ''<#if (col_has_next)>,</#if>
		</#list>
      },
      rules: {
      	<#assign tmp=0>
      	<#list commonList as col>
      	<#assign index=col_index?if_exists>
	      <#if col.isNotNull>
          <#if (tmp>0)>,</#if>${col.colName}: [{ required: true, message: this.$t('validate.required') }]
          <#assign tmp=tmp+1>
	      </#if>
      	</#list>
      }
    }
  },
  // 监听
  watch: {
    id: {
      handler: function(val, oldVal) {
        this.formId = this.id

        this.getFormData()
      },
      immediate: true
    }
  },
  created() {
    this.defaultForm = JSON.parse(JSON.stringify(this.form))
  },
  methods: {
    getWidth(even) {
      this.optionsWidth = even.srcElement.clientWidth + 'px'
    },
    // 保存数据
    handleSave() {
      this.$refs[this.formName].validate(valid => {
        if (valid) {
          this.saveData()
        } else {
          ActionUtils.saveErrorMessage()
        }
      })
    },
    // 提交保存数据
    saveData() {
      const data = this.form
      save(data).then(response => {
        this.$emit('callback', this)
        ActionUtils.saveSuccessMessage(response.message, (rtn) => {
          if (this.$utils.isEmpty(this.formId)) {
            this.$refs[this.formName].resetFields()
          }
          this.$emit('success', rtn)
        })
      }).catch((err) => {
        console.info(err)
      })
    },
    // 获取编辑数据
    getFormData() {
      if (this.$utils.isEmpty(this.formId)) {
        // 页面渲染完后初始化表单
        this.$nextTick(() => {
          // 重置表单
          this.form = JSON.parse(JSON.stringify(this.defaultForm))
          this.form.${convertUnderLine(model.variables.pidKey)} = this.parentId
          this.formValidate()
        })
      } else {
        this.formLoading = true
        get({ id: this.formId }).then(response => {
          this.form = response.data
          if (!this.readonly) {
            this.formValidate()
          }
          this.formLoading = false
        }).catch(() => {
          this.formLoading = false
        })
      }
    },
    /**
     * 表单验证
     */
    formValidate() {
      this.$nextTick(() => {
        this.$refs[this.formName].validate(() => {})
      })
    }
  }
}
</script>

