
  <el-card v-loading.fullscreen.lock="loading" class="box-card pending-business" :element-loading-text="$t('common.loading')">
    <div slot="header" class="clearfix">
      <span>{{ title }}</span>
      <ibps-desktop-toolbar ref="toolbar" :actions="[{ key: 'refresh' }, { key: 'more' }, { key: 'fullscreen' }, { key: 'collapse' }]" @action-event="handleActionEvent" />
    </div>
    <div ref="body" :style="{height:showHeight,width:'100%'}">
      <el-scrollbar
        style="height: 100%;width:100%;"
        wrap-class="ibps-scrollbar-wrapper"
      >
        <el-tabs
          v-model="pendingTabActiveName"
          class="pending-Tabs"
          @tab-click="()=>handleTabClick({
            'user-type':{ 'dataMode': 'column.dataMode', 'dataFrom': '{{BUSINESS_BASE_URL}}/bpm/received/query/pending/user2'},
            'org-belong':{ 'dataMode': 'column.dataMode', 'dataFrom': '{{BUSINESS_BASE_URL}}/bpm/received/query/pending/org2' },
            'org-principal':{ 'dataMode': 'column.dataMode', 'dataFrom': '{{BUSINESS_BASE_URL}}/bpm/received/query/pending/org/manager2'},
            'role-belong':{ 'dataMode': 'column.dataMode', 'dataFrom': '{{BUSINESS_BASE_URL}}/bpm/received/query/pending/role2'},
            'post-belong':{ 'dataMode': 'column.dataMode', 'dataFrom': '{{BUSINESS_BASE_URL}}/bpm/received/query/pending/position2'},
            'group-belong':{ 'dataMode': 'column.dataMode', 'dataFrom': '{{BUSINESS_BASE_URL}}/bpm/received/query/pending/group2'}
          })"
        >
          <el-tab-pane
            label="用户类型"
            name="user-type"
          >
            <ibps-list-group v-if="data && data.length >0">
              <ibps-list v-for="(d,i) in data" :key="i" style="padding: 13px 16px;" @click.native="handleFlowClick({taskId:d.taskId})">
                <div slot="label">{{ d.createTime|dateFormat }}</div>
                <el-link type="primary" :underline="false">{{ d.subject|removeHtmlTag }}</el-link>
                <el-avatar v-if="d.remindTimes === 0" slot="icon" :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                  {{ d.creator }}
                  <span slot="extra">
                    <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                    {{ d.status | filterStatus('pending') }}
                  </span>
                </el-avatar>
                <el-badge v-else slot="icon" :value="d.remindTimes" :max="99" class="item">
                  <el-avatar :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                    {{ d.creator }}
                    <span slot="extra">
                      <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                      {{ d.status | filterStatus('pending') }}
                    </span>
                  </el-avatar>
                </el-badge>
              </ibps-list>
            </ibps-list-group>
            <el-alert
              v-else
              :title="$t('common.noData')"
              :closable="false"
              type="warning"
            />
          </el-tab-pane>
          <el-tab-pane label="组织下所属人" name="org-belong">
            <ibps-list-group v-if="data && data.length >0">
              <ibps-list v-for="(d,i) in data" :key="i" style="padding: 13px 16px;" @click.native="handleFlowClick({taskId:d.taskId})">
                <div slot="label">{{ d.createTime|dateFormat }}</div>
                <el-link type="primary" :underline="false">{{ d.subject|removeHtmlTag }}</el-link>
                <el-avatar v-if="d.remindTimes === 0" slot="icon" :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                  {{ d.creator }}
                  <span slot="extra">
                    <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                    {{ d.status | filterStatus('pending') }}
                  </span>
                </el-avatar>
                <el-badge v-else slot="icon" :value="d.remindTimes" :max="99" class="item">
                  <el-avatar :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                    {{ d.creator }}
                    <span slot="extra">
                      <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                      {{ d.status | filterStatus('pending') }}
                    </span>
                  </el-avatar>
                </el-badge>
              </ibps-list>
            </ibps-list-group>
            <el-alert
              v-else
              :title="$t('common.noData')"
              :closable="false"
              type="warning"
            />
          </el-tab-pane>
          <el-tab-pane label="组织负责人" name="org-principal">
            <ibps-list-group v-if="data && data.length >0">
              <ibps-list v-for="(d,i) in data" :key="i" style="padding: 13px 16px;" @click.native="handleFlowClick({taskId:d.taskId})">
                <div slot="label">{{ d.createTime|dateFormat }}</div>
                <el-link type="primary" :underline="false">{{ d.subject|removeHtmlTag }}</el-link>
                <el-avatar v-if="d.remindTimes === 0" slot="icon" :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                  {{ d.creator }}
                  <span slot="extra">
                    <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                    {{ d.status | filterStatus('pending') }}
                  </span>
                </el-avatar>
                <el-badge v-else slot="icon" :value="d.remindTimes" :max="99" class="item">
                  <el-avatar :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                    {{ d.creator }}
                    <span slot="extra">
                      <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                      {{ d.status | filterStatus('pending') }}
                    </span>
                  </el-avatar>
                </el-badge>
              </ibps-list>
            </ibps-list-group>
            <el-alert
              v-else
              :title="$t('common.noData')"
              :closable="false"
              type="warning"
            />
          </el-tab-pane>
          <el-tab-pane label="角色下所属人" name="role-belong">
            <ibps-list-group v-if="data && data.length >0">
              <ibps-list v-for="(d,i) in data" :key="i" style="padding: 13px 16px;" @click.native="handleFlowClick({taskId:d.taskId})">
                <div slot="label">{{ d.createTime|dateFormat }}</div>
                <el-link type="primary" :underline="false">{{ d.subject|removeHtmlTag }}</el-link>
                <el-avatar v-if="d.remindTimes === 0" slot="icon" :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                  {{ d.creator }}
                  <span slot="extra">
                    <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                    {{ d.status | filterStatus('pending') }}
                  </span>
                </el-avatar>
                <el-badge v-else slot="icon" :value="d.remindTimes" :max="99" class="item">
                  <el-avatar :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                    {{ d.creator }}
                    <span slot="extra">
                      <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                      {{ d.status | filterStatus('pending') }}
                    </span>
                  </el-avatar>
                </el-badge>
              </ibps-list>
            </ibps-list-group>
            <el-alert
              v-else
              :title="$t('common.noData')"
              :closable="false"
              type="warning"
            />
          </el-tab-pane>
          <el-tab-pane label="岗位下所属人" name="post-belong">
            <ibps-list-group v-if="data && data.length >0">
              <ibps-list v-for="(d,i) in data" :key="i" style="padding: 13px 16px;" @click.native="handleFlowClick({taskId:d.taskId})">
                <div slot="label">{{ d.createTime|dateFormat }}</div>
                <el-link type="primary" :underline="false">{{ d.subject|removeHtmlTag }}</el-link>
                <el-avatar v-if="d.remindTimes === 0" slot="icon" :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                  {{ d.creator }}
                  <span slot="extra">
                    <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                    {{ d.status | filterStatus('pending') }}
                  </span>
                </el-avatar>
                <el-badge v-else slot="icon" :value="d.remindTimes" :max="99" class="item">
                  <el-avatar :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                    {{ d.creator }}
                    <span slot="extra">
                      <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                      {{ d.status | filterStatus('pending') }}
                    </span>
                  </el-avatar>
                </el-badge>
              </ibps-list>
            </ibps-list-group>
            <el-alert
              v-else
              :title="$t('common.noData')"
              :closable="false"
              type="warning"
            />
          </el-tab-pane>
          <el-tab-pane label="用户组所属人" name="group-belong">
            <ibps-list-group v-if="data && data.length >0">
              <ibps-list v-for="(d,i) in data" :key="i" style="padding: 13px 16px;" @click.native="handleFlowClick({taskId:d.taskId})">
                <div slot="label">{{ d.createTime|dateFormat }}</div>
                <el-link type="primary" :underline="false">{{ d.subject|removeHtmlTag }}</el-link>
                <el-avatar v-if="d.remindTimes === 0" slot="icon" :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                  {{ d.creator }}
                  <span slot="extra">
                    <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                    {{ d.status | filterStatus('pending') }}
                  </span>
                </el-avatar>
                <el-badge v-else slot="icon" :value="d.remindTimes" :max="99" class="item">
                  <el-avatar :src="getPhoto(d.instCreatorPhoto)" icon="el-icon-user-solid" @error="errorAvatarHandler">
                    {{ d.creator }}
                    <span slot="extra">
                      <ibps-icon name="dot-circle-o" style="color:#36c6d3" />
                      {{ d.status | filterStatus('pending') }}
                    </span>
                  </el-avatar>
                </el-badge>
              </ibps-list>
            </ibps-list-group>
            <el-alert
              v-else
              :title="$t('common.noData')"
              :closable="false"
              type="warning"
            />
          </el-tab-pane>
        </el-tabs>
      </el-scrollbar>
    </div>
  </el-card>

