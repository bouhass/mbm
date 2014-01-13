dataSource {
    pooled = true
    dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
    driverClassName = "com.mysql.jdbc.Driver"
    dialect = org.hibernate.dialect.MySQL5InnoDBDialect
    username = "user"
    password = "password"
    properties {
        maxActive = -1
        minEvictableIdleTimeMillis=1800000
        timeBetweenEvictionRunsMillis=1800000
        numTestsPerEvictionRun=3
        testOnBorrow=true
        testWhileIdle=true
        testOnReturn=true
        validationQuery="SELECT 1"
    }
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            url = "jdbc:mysql://localhost:3306/DEV_DB"
        }
    }
    devAmazon {
        dataSource {
            url = "jdbc:mysql://mbm-dev1.cof0xwuqd56q.eu-west-1.rds.amazonaws.com:3306/DEV_DB"
        }
    }
    demoAmazon {
        dataSource {
            url = "jdbc:mysql://mbm-dev1.cof0xwuqd56q.eu-west-1.rds.amazonaws.com:3306/DEMO_DB"
        }
    }
    teoAmazon {
        dataSource {
            url = "jdbc:mysql://mbm-dev1.cof0xwuqd56q.eu-west-1.rds.amazonaws.com:3306/TEO_DB"
        }
    }
    production {
        dataSource {
            url = "jdbc:h2:prodDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
}
