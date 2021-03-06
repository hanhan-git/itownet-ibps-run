
  <el-card :style="{height:cardHeight}" class="box-card">
    <div slot="header" class="clearfix">
      <span>{{ title }}</span>
      <ibps-desktop-toolbar
        ref="toolbar"
        :actions="[{ key: 'refresh' }, { key: 'more' }, { key: 'fullscreen' }, { key: 'collapse' }]"
        @action-event="handleActionEvent"
      />
    </div>
    <div ref="body" :style="{height:showHeight,width:'100%'}">
      <el-scrollbar
        style="height: 100%;width:100%;"
        wrap-class="ibps-scrollbar-wrapper"
      >
        <ibps-list-group v-if="data && data.length >0">
          <ibps-list
            v-for="(d,i) in data"
            :key="i"
            @click.native="handleFlowClick({instanceId:d.procInstId})"
          >
            <div slot="label">{{ d.createTime|dateFormat }}</div>
            <el-link type="primary" :underline="false">{{ d.subject|removeHtmlTag }}</el-link>
            <el-avatar slot="icon" :src="d.creatorPhoto" icon="el-icon-user-solid" @error="errorAvatarHandler">{{ d.creator }}</el-avatar>
            <div slot="extra">
              <ibps-icon name="dot-circle-o" style="color:#36c6d3" />{{ d.status|filterStatus('already') }}
            </div>
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

