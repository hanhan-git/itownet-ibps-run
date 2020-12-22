<#assign form=formData?eval>
<#---
********************************************
字段控件
field json的控件字段
classVars  表单对应的class值
isMain 是否主表
********************************************
-->
<#macro field_control field classVars isMain showVal idx isOne2one parentClassVars>
		<#assign keyTag><#if isMain>m<#else>s</#if></#assign>
		<#assign idxx>{{idx}}</#assign>
		<#assign controlName><#if isMain>${keyTag}:${classVars}:${field.name}<#elseif idx=='idx'>${keyTag}:${classVars}:${field.name}:{{idx}}<#elseif idx=='stat'>${keyTag}:${classVars}:${field.name}:<#noparse>${</#noparse>stat.index+1}</#if></#assign>
		<#assign val><#if showVal><#if field.dataType=='date'><fmt:formatDate value="<#noparse>${</#noparse><#if isOne2one>${parentClassVars}.</#if>${classVars}.${field.name}}"  pattern="${field.field_options.datefmt}"/><#else><#noparse>${</#noparse><#if isOne2one>${parentClassVars}.</#if>${classVars}.${field.name}}</#if></#if></#assign>
		<#switch field.field_type>
			<#case "hidden"><#---隐藏域-->
				<input type="hidden" name="${controlName}"  <#if showVal>value="${val}"</#if>/>
			<#break>
			<#case "text"><#---文本框-->
				<input type="text" class="fr-form-control" name="${controlName}" <#if showVal>value="${val}"</#if> validate="{<#if field.field_options.required>required:true<#else>required:false</#if><#if field.field_options.min_length>,minLength:${field.field_options.min_length}</#if><#if field.field_options.max_length>,maxLength:${field.field_options.max_length}</#if><#if field.field_options.data_format>,${field.field_options.data_format}:true</#if><#noparse>}</#noparse>"/>
			<#break>
			<#case "textarea"><#---多行文本框-->
				<textarea class="fr-form-control fr-control-textarea"  name="${controlName}"  validate="{<#if field.field_options.required>required:true<#else>required:false</#if><#if field.field_options.min_length>,minLength:${field.field_options.min_length}</#if><#if field.field_options.max_length>,maxLength:${field.field_options.max_length}</#if>}"><#if showVal>${val}</#if></textarea>
			<#break>
			<#case "editor"><#---富文本框-->
				<textarea class="fr-form-control fr-control-textarea" data-control="editor"   name="${controlName}" style="display: none;" validate="{<#if field.field_options.required>required:true<#else>required:false</#if><#if field.field_options.min_length>,minLength:${field.field_options.min_length}</#if><#if field.field_options.max_length>,maxLength:${field.field_options.max_length}</#if>}"><#if showVal><#noparse>${</#noparse>fn:escapeXml(${classVars}.${field.name})}</#if></textarea>
				<script id="${controlName}Editor" data-name="${controlName}" data-toggle='editor' type="text/plain"  ></script>
			<#break>
			<#case "number"><#---数字-->
				<input type="number"  class="fr-form-control"  name="${controlName}"  <#if showVal>value="${val}"</#if> validate="{<#if field.field_options.required>required:true<#else>required:false</#if><#if field.field_options.min>,minvalue:${field.field_options.min}</#if><#if field.field_options.max>,maxvalue:${field.field_options.max_length}</#if>}"/>
			<#break>
			<#case "radio"><#---单项选择-->
				<#list  field.field_options.options as option>
					<label class="fr-control-option radio-inline">
					    <input type="radio" name="${controlName}" value="${option.val}" defaultVal="${option.checked}" class="ibps" <#if showVal><c:if test="<#noparse>${</#noparse><#if isOne2one>${parentClassVars}.</#if>${classVars}.${field.name}==null}">defaultValue="true"</c:if></#if> <#if showVal><c:if test="<#noparse>${</#noparse><#if isOne2one>${parentClassVars}.</#if>${classVars}.${field.name}=='${option.val}'}">checked="checked"</c:if></#if>  validate="{<#if field.field_options.required>required:true<#else>required:false</#if>}"/>
					   	<span class="lbl">${option.label}</span>
				  </label>
			  </#list>
			<#break>
			<#case "checkbox"><#---多项选择-->
				<#list  field.field_options.options as option>
					<label class="fr-control-option checkbox-inline">
					    <input type="checkbox" name="${controlName}" class="ibps" value="${option.val}" <#if showVal><c:if test="<#noparse>$</#noparse>{fn:contains(<#if isOne2one>${parentClassVars}.</#if>${classVars}.${field.name}, '${option.val}')}">checked="checked"</c:if></#if> validate="{<#if field.field_options.required>required:true<#else>required:false</#if>}"/>
					   	<span class="lbl">${option.label}</span>
				  </label>
			  </#list>
			<#break>
			<#case "select"><#---下拉框-->
				<select class="fr-form-control" name="${controlName}"  value="<#noparse>${</#noparse><#if isOne2one>${parentClassVars}.</#if>${classVars}.${field.name}}" validate="{<#if field.field_options.required>required:true<#else>required:false</#if>}">
					 <#if field.field_options.include_blank_option>
					 <option value="">请选择</option>
					 </#if>
				  	<#list  field.field_options.options as option>
				    <option value="${option.val}" <#if showVal><c:if test="<#noparse>${</#noparse><#if isOne2one>${parentClassVars}.</#if>${classVars}.${field.name}=='${option.val}'}">selected="selected"</c:if></#if>>${option.label}</option>
				    </#list>
				</select>
			<#break>
			<#case "datePicker"><#---日期控件-->
				<div class="input-icon" >
					<i class="fa fa-calendar"></i>
					<input type="text" readonly="readonly" class="fr-form-control datepicker" datefmt="${field.field_options.datefmt}"   name="${controlName}"   <#if showVal>value="${val}"</#if> validate="{<#if field.field_options.required>required:true<#else>required:false</#if>}"/>
				</div>
			<#break>
			<#case "dictionary"><#---数据字典-->
				 <input type="hidden" id="${field.name}" name="${controlName}"  <#if showVal>value="${val}"</#if>/>
				<input type="text" readonly="readonly"  class="fr-form-control comboTree"
						 data-toggle="dictionary"   data-dic="${field.field_options.dictionary}" data-key="#${field.name}"
						 data-select_mode="<#if field.field_options.select_mode>${field.field_options.select_mode}</#if>"
						 data-display_mode="<#if field.field_options.display_mode>${field.field_options.display_mode}</#if>"
						 data-split="<#if field.field_options.split>${field.field_options.split}</#if>"
		                 <#if showVal>value="<#noparse>${</#noparse>f:getDictLabel2(<#if isOne2one>${parentClassVars}.</#if>${classVars}.${field.name},'${field.field_options.dictionary}', 'key','${field.field_options.display_mode}','${field.field_options.split}', '')}"</#if>  validate="{<#if field.field_options.required>required:true<#else>required:false</#if>}"/>
			<#break>
			<#case "autoNumber"><#---自动编号-->
				<div class="input-icon">
					<i class="fa fa-list-ol"></i>
					<input type="text"  readonly="readonly" class="fr-form-control" data-toggle="autoNumber"  data-identity="${field.field_options.identity}" data-init="${field.field_options.init}"   name="${controlName}"  <#if showVal>value="${val}"</#if> validate="{<#if field.field_options.required>required:true<#else>required:false</#if>}"/>
				</div>
			<#break>
			<#case "attachment"><#---附件-->
				<div name="div_attachment_container" data-media="${field.field_options.media}"   data-media_type="${field.field_options.media_type}"  data-max_file_size="${field.field_options.max_file_size}"   data-max_file_quantity="${field.field_options.max_file_quantity}">
					<div class="fr-files" ></div>
					<textarea style="display: none"   data-control="attachment"  name="${controlName}"  validate="{<#if field.field_options.required>required:true<#else>required:false</#if>}"><#if showVal>${val}</#if></textarea>
					<#if idx='idx'>
						<div class="file-select-trigger" data-toggle="file-upload">
							<label>
								<div class="plus">+</div>
								<div class="select-text">请选择上传文件</div>
							</label>
						</div>
					</#if>
				</div>
			<#break>
			<#case "office"><#---office-->
				<div data-toggle="office">
					<div id="${field.name}">
					</div>
					<input type="hidden" id="${field.name}_value" name="${controlName}" data-office_type="${field.field_options.office_type}" <#if showVal>value="${val}"</#if>/>
				</div>
				
				<#switch field.field_options.office_type>
				<#case "doc">
				<!--
				<script language="JScript" for="office控件对象" event="OnWordBeforeRightClick(Selection, IsCancel)">
					//屏蔽word右键事件
					//office控件对象.CancelWordRightClick=true;
				</script>
				<script language="JScript" for="office控件对象" event="OnWordBeforeDoubleClick(Selection, IsCancel)">
					//屏蔽word左键双击事件
					//office控件对象.CancelWordDoubleClick=true;
				</script>
				-->
				<#break>
				<#case "xls">
				<!--
				<script language="JScript" for="office控件对象" event="OnSheetBeforeRightClick(SheetName, row, col, IsCancel)">
					//屏蔽excel右键事件
					//office控件对象.CancelSheetRightClick=true;
				</script>
				<script language="JScript" for="office控件对象" event="OnSheetBeforeDoubleClick(SheetName, row, col, IsCancel)">
					//屏蔽excel左键双击事件
					//office控件对象.CancelSheetDoubleClick=true;
				</script>
				-->
				<#break>
				<#case "ppt">
				<!--
				<script language="JScript" for="office控件对象" event="OnPPTBeforeRightClick(Selection, IsCancel)">
					//屏蔽ppt右键事件
					//office控件对象.CancelPPTRightClick=true;
				</script>
				-->
				<#break>
				</#switch>
			<#break>
			<#case "selector"><#---选择器-->
				<div class="fr-selector" data-toggle="selector" data-type="${field.field_options.selector_type}" data-store="${field.field_options.store}"  <#if field.field_options.store=="bind">data-bind-id="${keyTag}:${classVars}:${field.field_options.bind_id}"</#if>  data-single="${field.field_options.is_single}">
					<ul class="selector-list"></ul>
					<textarea style="display: none"   data-control="selector"  name="${controlName}" ><#if showVal>${val}</#if></textarea>
				 </div>
			<#break>
			<#case "customDialog"><#---自定义对话框-->
				<div class="input-group" data-toggle="customdialog"  data-store="${field.field_options.store}" data-type="${field.field_options.dialog_type}" data-dialog="${field.field_options.dialog}" data-bind="${listToString(field.field_options.bind)}" data-name="${keyTag}:${classVars}:" data-idx = "<#if idx=='idx'>${idxx}<#elseif idx=='stat'><#noparse>${</#noparse>stat.index+1}</#if>" data-single="${field.field_options.is_single}" >
					<input type="text" readonly="readonly"  class="fr-form-control "  id="${controlName}"  <#if showVal></#if> validate="{<#if field.field_options.required>required:true<#else>required:false</#if>}"/>
					<input type="hidden" name="${controlName}" value="${val}"/>
					<span class="input-group-addon"><i class="fa fa-search-plus"></i></span>
				</div>
			<#break>
			<#case "address"><#---地址-->
				<div style="position: relative;">
	            	 <input class="fr-form-control" readonly type="text" data-toggle="address"   name="${controlName}"  <#if showVal>value="${val}"</#if> validate="{<#if field.field_options.required>required:true<#else>required:false</#if>}">
	         	</div>
			<#break>
			<#case "linkdata"><#---下拉框-->
				<select  name="${controlName}" class="form-control " data-toggle="select2" data-multiple="${field.field_options.multiple}"
		                             data-linkdata="${field.field_options.linkdata}" data-id="${field.field_options.link_config.id}" data-text="${field.field_options.link_config.text}" data-value="${val}"
		                             data-placeholder="${field.field_options.placeholder}"  validate="{<#if field.field_options.required>required:true<#else>required:false</#if><#noparse>}</#noparse>">
		        </select>
		    <#break>
		</#switch>
</#macro>
<#---
********************************************
list 转string
********************************************
-->
<#function listToString object>
 <#if object??>
        <#if object?is_enumerable>
            <#local json = '['>
            <#list object as item>
                <#if item?is_number >
                    <#if item_index &gt; 0 && json != "[" >
                        <#local json = json +',' >
                    </#if>
                    <#local json = json + '${item}'>
                <#elseif item?is_string>
                    <#if item_index &gt; 0 && json != "[" >
                        <#local json = json +',' >
                    </#if>
                    <#local json = json + '"${item?html!""?js_string}"'>
                <#elseif item?is_boolean  >
                    <#if item_index &gt; 0 && json != "[" >
                        <#local json = json +',' >
                    </#if>
                    <#local json = json + '${item?string("true", "false")}'>
                <#elseif item?is_enumerable && !(item?is_method) >
                    <#if item_index &gt; 0 && json != "[" >
                        <#local json = json +',' >
                    </#if>
                    <#local json = json + listToString(item)>
                <#elseif item?is_hash>
                    <#if item_index &gt; 0 && json != "[" >
                        <#local json = json +',' >
                    </#if>
                    <#local json = json + listToString(item)>
                </#if>
            </#list>
            <#return json + ']'>
        <#elseif object?is_hash>
            <#local json = "{">
            <#assign keys = object?keys>
            <#list keys as key>
                <#if object[key]?? && !(object[key]?is_method) && key != "class">
                    <#if object[key]?is_number>
                        <#if key_index &gt; 0 && json != "{" >
                            <#local json = json +',' >
                        </#if>
                        <#local json = json + "'${key}': ${object[key]}">
                    <#elseif object[key]?is_string>
                        <#if key_index &gt; 0 && json != "{" >
                            <#local json = json +',' >
                        </#if>
                        <#local json = json + "'${key}': '${object[key]?html!''?js_string}'">
                    <#elseif object[key]?is_boolean >
                        <#if key_index &gt; 0 && json != "{" >
                            <#local json = json +',' >
                        </#if>
                        <#local json = json + "'${key}': ${object[key]?string('true', 'false')}">

                    <#elseif object[key]?is_enumerable >
                        <#if key_index &gt; 0 && json != "{" >
                            <#local json = json +',' >
                        </#if>
                        <#local json = json + '"${key}":'+ listToString(object[key])>

                    <#elseif object[key]?is_hash>
                        <#if key_index &gt; 0 && json != "{" >
                            <#local json = json +',' >
                        </#if>
                        <#local json = json + "'${key}':"+ listToString(object[key])>
                    </#if>
                </#if>
            </#list>
            <#return json +"}">
        </#if>
    <#else>
        <#return "[]">
    </#if>
</#function>
<#---
********************************************
占比宽
********************************************
-->
<#function gridsToOccupy field>
<#assign occupy><#if field.field_options??>${field.field_options.grids_to_occupy}<#else>4</#if></#assign>
<#assign rtn>
<#if occupy =="1">
col-sm-3
<#elseif occupy =="2"  >
col-sm-6
<#elseif occupy =="3" >
col-sm-9
<#elseif occupy =="4"  >
col-sm-12
<#else>
col-sm-12
</#if></#assign>
 <#return rtn?trim>
</#function>

<#---
********************************************
子表控件
field json的控件字段
classVars  表单对应的class值
isMain 是否主表
********************************************
-->
<#macro sub_table_control field classVars subClassVars isMain>
		<#assign keyTag><#if isMain>m<#else>s</#if></#assign>
		<#assign tblName>${keyTag}:${subClassVars}</#assign>
		<#assign mode><#if field.field_options.mode??>${field.field_options.mode}<#else>inner</#if></#assign>
		<#assign width><#if mode=='inner'>45px<#else>75px</#if></#assign>
		<#if mode=='block' > <#-- 块模式 -->
			<#if field.field_options.relation == 'one2one'>
			<div class="fr_response_field  col-sm-12" name="${tblName}" data-mode="${mode}" data-required="${field.field_options.required}" data-relation="${field.field_options.relation}">
					<div class="fr-table-content">
						<div class="fr-table-header">
							<div class="fr-table-header-label">${field.label}</div>
							<div class="fr-table-tools">
							</div>
						</div>
						<div class="fr-table-block">
							<fieldset>
								<#list field.field_options.columns as column>
									<#if column.field_type == 'hidden' ||  column.field_options.hide>
			 							<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true idx='stat' isOne2one=true parentClassVars=classVars/>
									<#else>
										<div class="fr_response_field ${gridsToOccupy(column)}" >
							      		 	 <div class="fr-form-group"> 
											 	<label class="fr-control-label">${column.label}</label>
											  	<div class="fr-form-block" data-type="${column.field_options.default_value_type}">
													<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true idx='stat' isOne2one=true parentClassVars=classVars/>
											  		<#if field.field_options.default_value>${column.field_options.default_value}</#if>
											 	</div>
										  	</div>
										</div>
									</#if>
								</#list>
							</fieldset>
						</div>
					</div>
				</div>
			<#else>
				<c:choose>
					<c:when test="<#noparse>${empty </#noparse>${classVars}.${subClassVars}PoList}">
						<div class="fr_response_field  col-sm-12" name="${tblName}" data-mode="${mode}" data-required="${field.field_options.required}" data-relation="${field.field_options.relation}">
					<div class="fr-table-content">
						<div class="fr-table-header">
							<div class="fr-table-header-label">${field.label}</div>
							<div class="fr-table-tools">
								<a class="btn btn-primary fa fa-add js-add-record"  data-type="add"  href="javascript:void(0);">添加</a>
							</div>
						</div>
						<div class="fr-table-block">
							<fieldset>
								<#list field.field_options.columns as column>
									<#if column.field_type == 'hidden' ||  column.field_options.hide>
			 							<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true idx='stat' isOne2one=false parentClassVars=classVars/>
									<#else>
										<div class="fr_response_field ${gridsToOccupy(column)}" >
							      		 	 <div class="fr-form-group"> 
											 	<label class="fr-control-label">${column.label}</label>
											  	<div class="fr-form-block" data-type="${column.field_options.default_value_type}">
													<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true idx='stat' isOne2one=false parentClassVars=classVars/>
											  		<#if field.field_options.default_value>${column.field_options.default_value}</#if>
											 	</div>
										  	</div>
										</div>
									</#if>
								</#list>
							</fieldset>
						</div>
					</div>
				</div>
					</c:when>
					<c:otherwise>
						<c:forEach varStatus="stat" var="${subClassVars}" items="<#noparse>${</#noparse>${classVars}.${subClassVars}PoList}">
						<div class="fr_response_field  col-sm-12" name="${tblName}" data-mode="${mode}" data-required="${field.field_options.required}" data-relation="${field.field_options.relation}">
							<div class="fr-table-content">
								<div class="fr-table-header">
									<div class="fr-table-header-label">${field.label}</div>
									<div class="fr-table-tools">
										<c:choose>
											<c:when test="<#noparse>${stat.first}</#noparse>">
												<a class="btn btn-primary fa fa-add js-add-record"  data-type="add"  href="javascript:void(0);">添加</a>
											</c:when>
											<c:otherwise>
												<#list field.field_options.buttons as button>
													<a class="btn ${button.style} ${button.icon} js-${button.type}-record"  data-type="${button.type}"  href="javascript:void(0);">${button.label}</a>
												</#list>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<div class="fr-table-block">
									<fieldset>
										<#list field.field_options.columns as column>
											<#if column.field_type == 'hidden' ||  column.field_options.hide>
					 							<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true idx='stat' isOne2one=false parentClassVars=classVars/>
											<#else>
												<div class="fr_response_field ${gridsToOccupy(column)}" >
									      		 	 <div class="fr-form-group"> 
													 	<label class="fr-control-label">${column.label}</label>
													  	<div class="fr-form-block" data-type="${column.field_options.default_value_type}">
															<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true idx='stat' isOne2one=false parentClassVars=classVars/>
													  		<#if field.field_options.default_value>${column.field_options.default_value}</#if>
													 	</div>
												  	</div>
												</div>
											</#if>
										</#list>
									</fieldset>
								</div>
							</div>
						</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</#if>
		<#else><#-- 其他模式 -->
			<table name="${tblName}" data-mode="${mode}" data-required="${field.field_options.required}" class="table table-bordered table-hover table-condensed">
			<caption>
				<div class="fr-table-header-label">${field.label}</div>
				<div class="fr-table-tools">
					<#list field.field_options.buttons as button>
							<a class="btn ${button.style} ${button.icon} js-${button.type}-record"  data-type="${button.type}"  href="javascript:void(0);">${button.label}</a>
					</#list>
				</div>
			</caption>
			<thead>
				<tr>
		     		 <th class="fr_table_col_checkbox" width="${width}"><input role="checkbox" class="checkAll" name="${tblName}" type="checkbox"></th>
		      	<#list field.field_options.columns as column>
	      		 	 <#if column.field_type == 'hidden' ||  column.field_options.hide><#else>
	       			 <th>${column.label}</th>
	       			  </#if>
				</#list>
		      	<th class="fr_table_col_remove" width="${width}">管理</th>
		    </tr>
			</thead>
			<tbody>	
				<c:forEach varStatus="stat" var="${subClassVars}" items="<#noparse>${</#noparse>${classVars}.${subClassVars}PoList}">	
					<tr>	
						<td><input role="checkbox" class="cbox " type="checkbox" name="${tblName}" ></td>
			<#list  field.field_options.columns as column>
				 	 	 <#if column.field_type == 'hidden' || column.field_options.hide ><@field_control  field=field  classVars=classVars isMain=isMain showVal=true idx='stat' isOne2one=false parentClassVars=classVars/><#else>
				 		<td>
						<#if mode=='inner'>	<#-- 行内编辑模式 -->
							<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true idx='stat'isOne2one=false parentClassVars=classVars/>
						<#elseif mode =='dialog'>	<#-- 弹窗模式 -->
							<#assign val>
							<#if column.dataType=='date'>
								<fmt:formatDate value="<#noparse>${</#noparse>${classVars}.${column.name}}"  pattern="${column.field_options.datefmt}"/>
							<#else>
								<#noparse>${</#noparse>${classVars}.${column.name}}</#if></#assign>
							<#if column.field_type=="attachment">
								<div name="div_attachment_container" data-rights="r">
									<div class="fr-files" ></div>
									<textarea style="display: none"   data-control="attachment"  name="${keyTag}:${classVars}:${column.name}:<#noparse>${</#noparse>stat.index+1}" ><#noparse>${</#noparse>${subClassVars}.${column.name}}</textarea>
								</div>
							<#else>
							<input type="hidden" name="${keyTag}:${subClassVars}:${column.name}:<#noparse>${</#noparse>stat.index+1}"  value="<#noparse>${</#noparse>${subClassVars}.${column.name}}"/><span><#noparse>${</#noparse>${subClassVars}.${column.name}}</span>
							</#if>
						</#if>
						</td>	
						</#if>	
				</#list>
						<td class="fr_table_col_remove" width="${width}">
								<#if mode=='dialog'><a title="编辑" class="btn  btn-xs btn-outline btn-row js-edit-row" href="javascript:void(0);"><i class=" fa fa-edit  fa-lg fa-font-green"></i></a></#if>	
								<a title="删除" class="btn  btn-xs btn-outline btn-row js-remove-row" href="javascript:void(0);"><i class=" fa fa-times-circle-o  fa-lg fa-font-red"></i></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</#if>
		
	<script type="text/html" id="${tblName}:TrTemplate">
	<#if mode=='inner' > <#-- 行内编辑模式 -->
		<tr>
		  	<td><input role="checkbox" class="cbox " type="checkbox" name="${tblName}" ></td>
		 <#list  field.field_options.columns as column >
	 	 	 <#if column.field_type == 'hidden' || column.field_options.hide >
	 	 	 	<@field_control  field=field  classVars=classVars isMain=isMain showVal=false idx='idx' isOne2one=false parentClassVars=classVars/><#else><td>
				<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=false idx='idx' isOne2one=false parentClassVars=classVars/>
			</td>
			</#if>	
		</#list>
		  	<td class="fr_table_col_remove" width="${width}">
				<a title="删除" class="btn  btn-xs btn-outline btn-row js-remove-row" href="javascript:void(0);"><i class=" fa fa-times-circle-o  fa-lg fa-font-red"></i></a>
			</td>
		</tr>
	<#elseif mode =='dialog'><#-- 弹窗模式 -->
		<tr>
		  	<td><input role="checkbox" class="cbox " type="checkbox" name="${tblName}" ></td>
		 <#list  field.field_options.columns as column>
	 	 	 <#if column.field_type == 'hidden' || column.field_options.hide ><input type="hidden" name="${tblName}:${column.name}:{{idx}}"  value="{{${column.name}}}"/><#elseif column.field_type=="attachment">
	 	 	 <td>
	 	 	 <div name="div_attachment_container" data-rights="r">
					<div class="fr-files" ></div>
					<textarea style="display: none"   data-control="attachment"  name="${keyTag}:${classVars}:${column.name}" >{{${column.name}}}</textarea>
			</div>
			</td>
			<#else>
	 		<td>
	 			<input type="hidden" name="${tblName}:${column.name}:{{idx}}"  value="{{${column.name}}}"/><span>{{${column.name}}}<span>
	 		</td>
			</#if>	
		</#list>
		  	<td class="fr_table_col_remove" width="${width}">
		  		<a title="编辑" class="btn  btn-xs btn-outline btn-row js-edit-row" href="javascript:void(0);"><i class=" fa fa-edit  fa-lg fa-font-green"></i></a>
				<a title="删除" class="btn  btn-xs btn-outline btn-row js-remove-row" href="javascript:void(0);"><i class=" fa fa-times-circle-o  fa-lg fa-font-red"></i></a>
			</td>
		</tr>
	<#elseif mode =='block'><#-- 块模式 -->
	<div class="fr_response_field  col-sm-12" name="${tblName}" data-mode="${mode}" data-required="${field.field_options.required}" data-relation="${field.field_options.relation}">
					<div class="fr-table-content">
						<div class="fr-table-header">
							<div class="fr-table-header-label">${field.label}</div>
							<div class="fr-table-tools">
							<#list field.field_options.buttons as button>
								<a class="btn ${button.style} ${button.icon} js-${button.type}-record"  data-type="${button.type}"  href="javascript:void(0);">${button.label}</a>
							</#list>
							</div>
						</div>
						<div class="fr-table-block">
							<fieldset>
								<#list field.field_options.columns as column>
									<#if column.field_type == 'hidden' ||  column.field_options.hide>
			 							<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true idx='idx' isOne2one=false parentClassVars=classVars/>
									<#else>
										<div class="fr_response_field ${gridsToOccupy(column)}" >
							      		 	 <div class="fr-form-group"> 
											 	<label class="fr-control-label">${column.label}</label>
											  	<div class="fr-form-block" data-type="${column.field_options.default_value_type}">
													<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true idx='idx' isOne2one=false parentClassVars=classVars/>
											  		<#if field.field_options.default_value>${column.field_options.default_value}</#if>
											 	</div>
										  	</div>
										</div>
									</#if>
								</#list>
							</fieldset>
						</div>
					</div>
				</div>
	</#if>
	</script>
</#macro>
<#---
********************************************
字段  
********************************************
-->
<#macro response_field field tableName isMain>
	<#assign classVars>${tableMap[tableName]}</#assign>
	<#assign keyTag><#if isMain>m<#else>s</#if></#assign>
	<#if field.field_type =='table'>  <#--子表 -->
		<#if tableMap[tableName+'_isGenSub']?exists && tableMap[tableName+'_isGenSub'] = 'true' && tableMap[tableName+'_hasSub']?exists && tableMap[tableName+'_hasSub']=='true'>
		<#assign fieldname=field.field_name>
		<#assign subClassVars><#if tableMap[fieldname?lower_case] != null && tableMap[fieldname?lower_case] != ''>${tableMap[fieldname?lower_case]?trim}<#elseif tableMap[fieldname?upper_case] != null && tableMap[fieldname?upper_case] != ''>${tableMap[fieldname?upper_case]?trim}<#else>${tableMap[fieldname]?trim}</#if></#assign>
		<@sub_table_control  field=field classVars=classVars subClassVars=subClassVars isMain=false/>
		</#if>
	<#else >
		 	 <#if field.field_type == 'tab_break'><#--选项卡-->
			<div  class="step-tab " id="${field.name}"  data-label = "${field.label}"></div>
		 	 <#elseif field.field_type == 'hidden' ||  field.field_options.hide>
		 			<@field_control  field=field  classVars=classVars isMain=isMain showVal=true idx=0 isOne2one=false parentClassVars=classVars/>

			<#elseif field.field_type == 'page_break'><#--分页 -->
			<div   class="step-page"   data-title = "${field.label}" data-next = "${field.field_options.next_page}"  data-prev = "${field.field_options.prev_page}"></div>
			<#elseif field.field_type == 'fold_card'><#--折叠卡 -->
			<div class="fr_response_field ${gridsToOccupy(field)}" >
			 	<div class="panel-fold-card" data-toggle="collapse"
							data-f_id="${field.name}" data-open="${field.field_options.open}" 
							data-end = "${keyTag}:${classVars}:${field.name}">
							<div class="panel-heading">
								<h4 class="panel-title">${field.label}</h4>
							</div>
						</div>
			</div>
			<div class="panel"  f_id="${field.name}" ></div>
			 <#else>
		 	<div class="fr_response_field ${gridsToOccupy(field)}" >
			 	<div class="fr-form-group"> 
				 	<label class="fr-control-label">${field.label}</label>
				  	<div class="fr-form-block" data-type="${field.field_options.default_value_type}">
							      <@field_control  field=field  classVars=classVars isMain=isMain showVal=true idx=0 isOne2one=false parentClassVars=classVars/>
				  					<#if field.field_options.default_value>${field.field_options.default_value}</#if>
				 	</div>
			  	</div>
			</div>
		 </#if>
	</#if>
</#macro>
<#---
********************************************
以下是表单模版
********************************************
-->
<form  class="fr-form"  id="${classVar}Form" action="save.htm" >
	<#list  form.fields as field>
		<@response_field  field=field tableName=form.code isMain=true/>
	</#list>
</form>