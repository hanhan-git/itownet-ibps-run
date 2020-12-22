
  <el-card class="box-card">
    <div slot="header" class="clearfix">
      <span>{{ title }}</span>
      <ibps-desktop-toolbar ref="toolbar" :actions="[{ key: 'refresh' }, { key: 'more' }, { key: 'fullscreen' }, { key: 'collapse' }]" @action-event="handleActionEvent" />
    </div>
    <div ref="body" :style="{height:showHeight,width:'100%'}">
      <el-scrollbar
        style="height: 100%;width:100%;"
        wrap-class="ibps-scrollbar-wrapper"
      >
        <ibps-list-group v-if="data && data[0].data.length >0">
          <ibps-list v-for="(d,i) in data[0].data" :key="i" :label="d.createTime" @click.native="handleFlowClick({defId:d.id})">
            <el-link type="primary" :underline="false" target="_blank">{{ d.name|removeHtmlTag }}</el-link>
            <div slot="extra"><ibps-icon name="dot-circle-o" style="color:#36c6d3" />{{ d.status|filterStatus('favorites') }} </div>
          </ibps-list>
        </ibps-list-group>
        <el-alert
          v-else
          :title="$t('common.noData')"
          :closable="false"
          type="warning"
        />
      </el-scrollbar>
    </div>
  </el-card>


