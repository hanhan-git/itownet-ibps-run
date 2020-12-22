<#assign form=formData?eval>
<#---
********************************************
字段控件
field json的控件字段
classVar  表单对应的class值
isMain 是否主表
********************************************
-->
<#macro field_control field classVars isMain showVal isOne2one parentClassVars>
	<#assign keyTag><#if isMain>m<#else>s</#if></#assign>
	<#assign val><#if showVal><#if isOne2one>${parentClassVars}.</#if>${classVars}.${field.name}</#if></#assign>
	<#switch field.field_type>
		<#case "hidden"><#---隐藏域-->
				<p class="form-control-static"><#noparse>${</#noparse>${classVars}.${field.name}}</p>
		<#break>
		<#case "text"><#---文本框-->
			<p class="form-control-static"><#noparse>${</#noparse>${val}}</p>
		<#break>
		<#case "textarea"><#---多行文本框-->
			<p class="form-control-static"><#noparse>${</#noparse>${val}}</p>
		<#break>
		<#case "editor"><#---富文本框-->
			<#noparse>${</#noparse>${classVars}.${field.name}}
		<#break>
		<#case "number"><#---数字-->
			<p class="form-control-static"><#noparse>${</#noparse>${val}}</p>
		<#break>
		<#case "radio"><#---单项选择-->
			<p class="form-control-static"><#list  field.field_options.options as option><c:if test="<#noparse>${</#noparse>${val}=='${option.val}'}">${option.label}</c:if></#list></p>
		<#break>
		<#case "checkbox"><#---多项选择-->
			<p class="form-control-static"><#list  field.field_options.options as option><c:if test="<#noparse>${</#noparse>fn:contains(${val}, '${option.val}')}">${option.label}&nbsp;</c:if></#list></p>
		<#break>
		<#case "select"><#---下拉框-->
			<p class="form-control-static"><#list  field.field_options.options as option><c:if test="<#noparse>${</#noparse>${val}=='${option.val}'}">${option.label}</c:if></#list></p>
		<#break>
		<#case "datePicker"><#---日期控件-->
			<#assign val><#if field.dataType=='date'><fmt:formatDate value="<#noparse>${</#noparse>${val}}"  pattern="${field.field_options.datefmt}"/><#else><#noparse>${</#noparse>${val}}</#if></#assign>
			<p class="form-control-static">${val}</p>
		<#break>
		<#case "dictionary"><#---数据字典-->
			 <p class="form-control-static"><#noparse>${</#noparse>f:getDictLabel2(${val},'${field.field_options.dictionary}', 'key','${field.field_options.display_mode}','${field.field_options.split}', '')}</p>
		<#break>
		<#case "autoNumber"><#---自动编号-->
			<p class="form-control-static"><#noparse>${</#noparse>${classVars}.${field.name}}</p>
		<#break>
		<#case "attachment"><#---附件-->
			<div name="div_attachment_container" data-rights="r">
				<div class="fr-files" ></div>
				<textarea style="display: none"   data-control="attachment"  name="${keyTag}:${classVar}:${field.name}" ><#noparse>${</#noparse>${val}}</textarea>
			</div>
		<#break>
		<#case "office"><#---office-->
			<div data-toggle="office">
				<div id="${field.name}">
				</div>
				<input type="hidden" id="${field.name}_value" data-office_type="${field.field_options.office_type}" value="<#noparse>${</#noparse>${classVars}.${field.name}}"/>
			</div>
		<#break>
		<#case "selector"><#---选择器-->
				<div class="fr-selector" data-toggle="selector" data-type="${field.field_options.selector_type}" data-store="${field.field_options.store}"  <#if field.field_options.store=="bind">data-bind-id="${keyTag}:${classVars}:${field.field_options.bind_id}"</#if>  data-single="${field.field_options.is_single}">
					<ul class="selector-list"></ul>
					<textarea style="display: none"   data-control="selector"  name="${keyTag}:${classVars}:${field.name}" ><#noparse>${</#noparse>${val}}</textarea>
				</div>
		<#break>
		<#case "customDialog"><#---自定义对话框-->
			<div class="input-group" data-toggle="customdialog"  data-store="${field.field_options.store}" data-type="${field.field_options.dialog_type}" data-dialog="${field.field_options.dialog}"  >
					<input type="text" readonly="readonly"  class="fr-form-control "  id="${keyTag}:${classVars}:${field.name}" />
					<input type="hidden" name="${keyTag}:${classVars}:${field.name}" value="<#noparse>${</#noparse>${val}}"/>
					<span class="input-group-addon"><i class="fa fa-search-plus"></i></span>
				</div>
		<#break>
		<#case "address"><#---地址-->
			<p class="form-control-static"><#noparse>${</#noparse>${val}}</p>
		<#break>
		<#case "linkdata"><#---下拉框-->
				<select  name="${controlName}" class="form-control " data-toggle="select2" data-multiple="${field.field_options.multiple}"
		                             data-linkdata="${field.field_options.linkdata}" data-id="${field.field_options.link_config.id}" data-text="${field.field_options.link_config.text}" data-value="<#noparse>${</#noparse>${val}}"
		                             data-placeholder="${field.field_options.placeholder}"  validate="{<#if field.field_options.required>required:true<#else>required:false</#if><#noparse>}</#noparse>">
		        </select>
		    <#break>
	</#switch>
</#macro>
<#macro sub_table_control field classVars subClassVars isMain>
		<#assign keyTag><#if isMain>m<#else>s</#if></#assign>
		<#assign tblName>${keyTag}:${subClassVars}</#assign>
		<#assign mode><#if field.field_options.mode??>${field.field_options.mode}<#else>inner</#if></#assign>
		<#if mode=='block' > <#-- 块模式 -->
			<#if field.field_options.relation == 'one2one'>
			<div class="fr_response_field  col-sm-12" name="${tblName}" data-mode="${mode}" data-required="${field.field_options.required}" data-relation="${field.field_options.relation}">
					<div class="fr-table-content">
						<div class="fr-table-header">
							<div class="fr-table-header-label">${field.label}</div>
							<div class="fr-table-tools "></div>
						</div>
						<div class="fr-table-block">
							<fieldset>
								<#list field.field_options.columns as column>
									<#if column.field_type == 'hidden' ||  column.field_options.hide>
									<#else>
										<div class="fr_response_field ${gridsToOccupy(column)}" >
							      		 	 <div class="fr-form-group"> 
											 	<label class="fr-control-label">${column.label}</label>
											  	<div class="fr-form-block" data-type="${column.field_options.default_value_type}">
													<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true isOne2one=true parentClassVars=classVars/>
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
				<c:forEach varStatus="stat" var="${subClassVars}" items="<#noparse>${</#noparse>${classVars}.${subClassVars}PoList}">
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
											<#else>
												<div class="fr_response_field ${gridsToOccupy(column)}" >
									      		 	 <div class="fr-form-group"> 
													 	<label class="fr-control-label">${column.label}</label>
													  	<div class="fr-form-block" data-type="${column.field_options.default_value_type}">
															<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true  isOne2one=false parentClassVars=classVars/>
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
				</#if>
		<#else><#-- 其他模式 -->
		<table name="${tblName}" class="table table-bordered table-hover table-condensed">
			<caption>
				<div class="fr-table-header-label">${field.label}</div>
			</caption>
			<thead>
				<tr>
		      	<#list field.field_options.columns as column>
	      		 	 <#if column.field_type == 'hidden' ||  column.field_options.hide><#else>
	       			 <th>${column.label}</th>
	       			 </#if>
				</#list>
		    </tr>
			</thead>
			<tbody>	
				<c:forEach var="${subClassVars}" items="<#noparse>${</#noparse>${classVars}.${subClassVars}PoList}">	
					<tr>	
				 <#list  field.field_options.columns as column>
				 	 	 <#if column.field_type == 'hidden' || column.field_options.hide ><#else>
				 		<td>
							<@field_control  field=column  classVars=subClassVars isMain=isMain showVal=true isOne2one=false parentClassVars=classVars/>
						</td>	
						  </#if>	
				</#list>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</#if>
</#macro>
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
字段
********************************************
-->
<#macro response_field field tableName isMain>
	<#assign classVars>${tableMap[tableName]}</#assign>
	<#if field.field_type =='table'>  <#-- 子表 -->
		<#if tableMap[tableName+'_isGenSub']?exists && tableMap[tableName+'_isGenSub'] = 'true' && tableMap[tableName+'_hasSub']?exists && tableMap[tableName+'_hasSub']=='true'>
		<#assign fieldname=field.field_name>
		<#assign subClassVars><#if tableMap[fieldname?lower_case] != null && tableMap[fieldname?lower_case] != ''>${tableMap[fieldname?lower_case]?trim}<#elseif tableMap[fieldname?upper_case] != null && tableMap[fieldname?upper_case] != ''>${tableMap[fieldname?upper_case]?trim}<#else>${tableMap[fieldname]?trim}</#if></#assign>
		<@sub_table_control field=field classVars=classVars subClassVars=subClassVars isMain=false/>
		</#if>
	<#else >
         <#if field.field_type == 'tab_break'><#--选项卡-->
			<div  class="step-tab " id="${field.name}"  data-label = "${field.label}"></div>
		 	 <#elseif field.field_type == 'hidden' ||  field.field_options.hide>
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
				  	<div class="fr-form-block">
				  		<#if (field.dataType=="date")>
							<p class="form-control-static"><fmt:formatDate value="<#noparse>${</#noparse>${classVars}.${field.name}}" /></p>		
						<#else>	
							<@field_control  field=field  classVars=classVars isMain=isMain showVal=true isOne2one=false parentClassVars=classVars/>
							<#if field.field_options.default_value>${field.field_options.default_value}</#if>
						</#if>		
				 	</div>
			  	</div>
			</div>
		 </#if>
	</#if>
</#macro>
<#---
********************************************
以下是模版
********************************************
-->
	<form  class="fr-form"  id="${classVar}FormGet" >
	<#list  form.fields as field>
		<@response_field  field=field tableName=form.code isMain=true/>
	</#list>
	</form>