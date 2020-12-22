package com.lc.ibps;

import com.ctrip.framework.apollo.spring.annotation.EnableApolloConfig;

import com.lc.ibps.auth.constants.ApiImportType;
import com.lc.ibps.auth.domain.AuthClient;
import com.lc.ibps.base.core.util.AppUtil;
import com.lc.ibps.base.core.util.EnvUtil;
import com.lc.ibps.base.framework.validation.handler.HandlerValidationErrors;
import com.lc.ibps.base.framework.validation.handler.impl.UniqueHandlerValidation;
import com.lc.ibps.base.framework.validation.handler.impl.UniqueHandlerValidator;
import com.lc.ibps.boot.service.AutoService;
import com.lc.ibps.cloud.bootstrap.AbstractBasicCommandLineRunner;
import com.lc.ibps.cloud.bootstrap.IbpsApplication;
import com.lc.ibps.cloud.utils.ScheduledUtil;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.mongo.MongoDataAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
import org.springframework.boot.autoconfigure.mongo.MongoAutoConfiguration;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.ImportResource;
import org.springframework.core.env.Environment;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;


@EnableApolloConfig
@SpringBootApplication
@ServletComponentScan
@EnableAutoConfiguration(exclude={
        DataSourceAutoConfiguration.class,
        DataSourceTransactionManagerAutoConfiguration.class,
        MongoAutoConfiguration.class,
        MongoDataAutoConfiguration.class/*,
  	org.springframework.cloud.client.serviceregistry.ServiceRegistryAutoConfiguration.class,
	org.springframework.cloud.client.serviceregistry.AutoServiceRegistrationAutoConfiguration.class*/
})
@ImportResource(locations={"classpath:conf/ibps-context.xml"})
public class IbpsItowProviderRunApplication extends AbstractBasicCommandLineRunner {

    private static final Logger LOGGER = org.slf4j.LoggerFactory.getLogger(IbpsItowProviderRunApplication.class);

    @Autowired
    private Environment env;
    @Resource
    private AutoService autoService;

    public static void main(String[] args) throws IOException {
        try {
            IbpsApplication.run(IbpsItowProviderRunApplication.class, args);
        }
        catch (Exception e) {
            LOGGER.error(e.getMessage(), e);
        }
    }

    @Override
    protected void ext() {
        // auto.import.api.open
        boolean isOpen = EnvUtil.getProperty(env, "auto.import.api.open", Boolean.class, true);
        if(isOpen) {
            long period = EnvUtil.getProperty(env, "auto.import.api.interval", Long.class, 480L);
            String key = "boot.auto.import.api";
            UniqueHandlerValidator uniqueHandlerValidator = AppUtil.getBean(UniqueHandlerValidator.class);
            AuthClient authClient = AppUtil.getBean(AuthClient.class);
            Function<Void, Void> execution = new Function<Void, Void>() {

                @Override
                public Void apply(Void t) {
                    Void result = null;
                    try {
                        uniqueHandlerValidator.setValidation(UniqueHandlerValidation.createUniqueHandlerValidation(key, "import"));
                        HandlerValidationErrors errors = uniqueHandlerValidator.validate(key);
                        if (null == errors || !errors.hasError()) {
                            autoService.autoImportApi(ApiImportType.NORMAL.getValue());
                            authClient.renewalSystemExpriedTime();
                        }
                    } catch (Exception e) {
                        logger.warn(e.getMessage(), e);
                    } finally {
                        uniqueHandlerValidator.processAfterInvoke();
                    }
                    return result;
                }

            };
            ScheduledUtil.createAndRunningScheduledThreadPoolExecutor(1, "auto-import-api", 5L, period, TimeUnit.MINUTES, execution);
        }
    }

}
