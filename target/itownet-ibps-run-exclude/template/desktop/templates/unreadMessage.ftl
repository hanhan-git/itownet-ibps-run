  
  <el-card :style="{height:cardHeight}" class="box-card">
    <div>
      <div class="tabs-title">
        <ibps-icon name="commenting" />
        <span>{{ title }}</span>
      </div>
      <div class="tabs-toolbar">
        <ibps-desktop-toolbar ref="toolbar" :actions="[{ key: 'refresh' }, { key: 'more' }, { key: 'fullscreen' }, { key: 'collapse' }]" @action-event="handleActionEvent" />
      </div>
      <div ref="body">
        <el-tabs
          ref="unreadMessageTabs"
          v-model="activeName"
          @tab-click="()=>handleClick({
            'innerMessage':{ 'dataMode': 'column.dataMode', 'dataFrom': '{{PLATFORM_BASE_URL}}/desktop/facade/unread/inner/message' },
            'system':{ 'dataMode': 'column.dataMode', 'dataFrom': '{{PLATFORM_BASE_URL}}/desktop/facade/unread/system/message' }
          })"
        >
          <el-tab-pane label="内部" name="innerMessage">
            <div ref="tabsContent" :style="{height:showHeight,width:'100%'}" class="tabs-content">
              <el-scrollbar
                style="height: 100%;width:100%;"
                wrap-class="ibps-scrollbar-wrapper"
              >
                <ibps-list-group v-if="data && data.length >0">
                  <ibps-list v-for="(d,i) in data" :key="i">
                    <div slot="label">{{ d.createTime|dateFormat }}</div>
                    <div slot="icon"><ibps-icon name="bolt" style="color:#5cb85c;margin:5px 0 0 5px;" /></div>
                    <el-link type="primary" :underline="false" @click="handleUnreadMessage(d.id)">{{ d.subject }}</el-link>
                    <div slot="extra">
                      <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                      {{ d.messageType | filterStatus('unreadMessage') }}
                    </div>
                  </ibps-list>
                </ibps-list-group>
                <el-alert
                  v-else
                  :closable="false"
                  title="当前没有记录。"
                  type="warning"
                />
              </el-scrollbar>
            </div>
          </el-tab-pane>
          <el-tab-pane label="系统" name="system">
            <div ref="tabsContent" :style="{height:showHeight,width:'100%'}" class="tabs-content">
              <el-scrollbar
                style="height: 100%;width:100%;"
                wrap-class="ibps-scrollbar-wrapper"
              >
                <ibps-list-group v-if="data && data.length >0">
                  <ibps-list v-for="(d,i) in data" :key="i">
                    <div slot="label">{{ d.createTime|dateFormat }}</div>
                    <div slot="icon"><ibps-icon name="bolt" style="color:#5cb85c;margin:5px 0 0 5px;" /></div>
                    <el-link type="primary" :underline="false" @click="handleUnreadMessage(d.id)">{{ d.subject }}</el-link>
                    <div slot="extra">
                      <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                      {{ d.messageType | filterStatus('unreadMessage') }}
                    </div>
                  </ibps-list>
                </ibps-list-group>
                <el-alert
                  v-else
                  :closable="false"
                  title="当前没有记录。"
                  type="warning"
                />
              </el-scrollbar></div>
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </el-card>