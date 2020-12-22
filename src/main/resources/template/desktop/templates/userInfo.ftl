 <el-card class="box-card" style="height:100%">
    <div ref="body" :style="{height:getHeight(),width:'100%'}">
      <ibps-item class="ibps-item-content">
        <span class="ibps-item-content-title">您好！<span v-if="data&&data.orgName!==''">{{ data.orgName }}的</span><label v-if="data&&data.fullname!==''">{{ data.fullname }}</label><label v-if="data&&data.gender!==''">{{ data.gender|filterStatus('gender') }}</label> </span><br><br>
        <div slot="label" class="ibps-item-content-label">
          <span v-if="data&&data.orgName!==''">所属组织：{{ data.orgName }}<br><br></span>
          <span v-if="data&&data.mobile!==''">联系电话：{{ data.mobile }}<br><br></span>
          <span v-if="data&&data.email!==''">邮箱：{{ data.email }}<br><br></span>
          <span v-if="data&&data.address!==''">地址：{{ data.address }}</span>
        </div>
        <div slot="icon">
          <el-avatar
            v-if="data"
            :icon="data.photo===''?'ibps-icon-user-circle':null"
            :src="getPhoto(data.photo)"
            :size="100"
            style="font-size:100px;color: #C0C4CC;background: #fff;"
          >
            <img :src="getPhoto(data.photo)" class="photo-img" @error="errorAvatarHandler(data)">
          </el-avatar>
        </div>
      </ibps-item>
    </div>
  </el-card>