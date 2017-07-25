# configuration for deployment and management scripts by adam.chalat@comarch.com (last update: 21.07.2017)

#--------------------------------------------------------------------#
#----------------------- INITIAL REQUIREMENTS -----------------------#
#--------------------------------------------------------------------#

# ENV CONFIGURATION: first column: environment name, second: node type, third: external IP address (connection between separated devices), fourth: priority of node, fifth: user name, sixth: default path, seventh: machine IP address
# IMPORTANT: environments definition for common file (distinction between multiple clients) should be decalred in <projects-dir>/project-configuration file (name of each environment must be unique) - structure: project folder and environments
# IMPORTANT: duplicated IP address for additional components (TUM, BPC) should be added below unambiguous entries (script location.finder breaks after first occurrence)
# IMPORTANT: hostnames numbers should be declared descending (fourth column)

#--------------------------------------------------------------------#
#----------------- AVAILABLE CONFIGURATION STRINGS ------------------#
#--------------------------------------------------------------------#

# -------------------------------------------
# >>> IMPLEMENTATION SERVER CONFIGURATION <<<
# -------------------------------------------
# 'DEPLOY_TRIGGER' determines name of deployment plan for which should be triggered automatically (first column: environment name, second: deployment plan)
# 'URL_PROXY' determines proxy, if required, to send messages to remote web service (listed environments and at last position proxy address: http://<url_address>)
# 'UPLOAD_TRIGGER' determines default location for logs: ${LOGS_DIR}/Extract_package/${UPLOAD_TRIGGER}/${DATE}

# -------------------------------------------------------
# >>> DEPLOYMENT 3RD PARTY APPLICATIONS CONFIGURATION <<<
# -------------------------------------------------------
# 'ARTIFACTORY_REPOSITORIES' determines names of available repositories
# 'ARTIFACTORY_${ENV}' determines in first column: default location - ${BIN_REPO}/uploaded_packages/${DEFAULT_PATH}, second: repository branch name, third: package separator
# 'ARTIFACTORY_${ENV}' determines in fourth: components, that shoudn't be overwritten, fifth: components downloaded once per branch, sixth: components downloaded for each version in branch
# 'ART_CREDENTIALS' defines credentials for artifactory repository (username, password and http path)
# 'BAMBOO_PATH' defines in first column: http path for bamboo application, in second: user credentials and in third: password credentials
# 'GIT_CONFIGURATION_IMPORTER_REMOTE' determines location of upstream (implementation) GIT repository (destiny: configuration importer configuration)
# 'GIT_IMPLEMENTATION_DIR' determines full path to repository on implementation ITOPS server (directly to the project)
# 'GIT_LIQUIBASE_REMOTE' determines location of upstream (implementation) GIT repository (destiny: liquibases)
# 'GIT_PATH' determines location of local GIT repository (used for development purposes by productization team) - first definition: offer project
# 'GIT_ZOOKEEPER_REMOTE' determines location of remote (implementation) GIT repository (destiny: configuration storage)
# 'REMOTE_SERVICES' determines which remote and local webservice should be checked for availability (JFrog Artifactory, Atlassian Bamboo and GitLAB)
# 'SLACK_CREDENTIALS' determines in first column: webhook, second: room ID (send messages during deployment done with Atlassian Bamboo oraz Jfrog Artifactory)

# -------------------------------
# >>> ENVIRONMENTS DEFINITION <<<
# -------------------------------
# 'ENV_LIST' is used in management scripts and for initial configuration (common script) - structure <ENV_no1>, <ENV_no2>
# 'HA_RELEASE' determines start of whole CRM on every node, except ESB which is started only on main node (based on RedHat PaceMaker) (additionally relates to JackRabbit deployment)
# 'SYSTEM_VERSION' determines version of installed release (supported versions: 7.0, 7.1, 7.2, 7.3) (configuration accepts only digits, without dots)

# ------------------------------------------
# >>> COMARCH APPLICATIONS CONFIGURATION <<<
# ------------------------------------------
# 'CRM_APPS' defines available components for CRM application (supported: all, batch, bpm, esb10k, esb11k, logic, presentation)
# 'CRM_PORTS' defines ports for CRM components (presentation port is read from values_properties): logic_port batch_logic_port bpm_port esb10k_port esb11k_port presentation_embedded_port presentation_embedded_https_port
# 'CQRS_START' determines on which environments omponent launching is required
# 'DPS_SIDS' defines names of DPS SIDS
# 'ESB_11000' determines for which environments component launching is required
# 'INSTANCE_CPM_START' determines on which environments component launching is required
# 'PARALLEL_PRESENTATIONS' determines for which environments should be started parallel presentation (by default on port 15000 and 15001)
# 'TUM_APP_CONF' determines which components should be started/turned off (HTTPD, CAS, RESTAPI) - available switches: true or false
# 'TYTAN_SESSIONS' determines schema which has required privilieges to remove tytan sessions

# ----------------------------------
# >>> ENVIRONMENTS CONFIGURATION <<<
# ----------------------------------
# '${ENV}_APPS_CLUSTERING' determines which applications should be clustered, applies to AIF, BSS (BACKEND and/or FRONTEND), BPC, RMQ (RabbitMQ), TUM applications 
# '${ENV}_CONFIGURATION' determines in first column: update and validation of terminal configuration (CHECK_TERMINAL_CONF), in second: hot deploy (HOT_DEPLOY), in third: SSH keys update (SSH_UPDATE), in fourth: applications verification (CHECK_APPS)
# '${ENV}_CONFIGURATION' penultimate row determines inclusion/exclusion of obsolete files removal mechanism (TRUE/FALSE), last row determines respectively for archiving logfiles mechanism
# '${ENV}_DATAUPGRADE' determines values for migration process (first column: crm baseline, second column: bs baseline, third column: mbcore column)
# '${ENV}_ES' determines ElasticSearch's: address (direct login: <address>/_plugin/head/), username and password
# '${ENV}_ES_CONF' determines on which nodes ElasticSeach cluster is installed (structure: <hostname>:<BSS,BPC>)
# '${ENV}_ES_MULTI_CLUSTER' determines ElasticSearch's clusters which are deployed and supported (BSS and/or BPC instances)
# '${ENV}_FDR_CONFIGURATION' determines configuration for FDRs import (arguments, respectively: HOST, PORT, SID, SCHEMA, PASSWORD)
# '${ENV}_ORACLE' determines IP addresses for databases (first column: BS - required users: PI, BS, MBCORE, TUM; second column: CRM - required users: CRM, LIFERAY, BPM, ESB, BSSSUITE)
# '${ENV}_RABBIT_NODES' determines on which nodes RabbitMQ is clustered (structure: <IP_ADDRESS>:<TRANSPORT_PORT>)
# '${ENV}_ZNODES' determines on which environments should be checked ZK propagation (<ZNODE>:<USERNAME>@<IP_ADDRESS>)

# ------------------------------------------------------------
# >>> DEPLOYMENT OPTIONS DEDICATED FOR TARGET ENVIRONMENTS <<<
# ------------------------------------------------------------
# 'BSS_LIST' determines which BSS components should be deployed - sequence definition, without commas (*bss-frontend-*:FRONTEND_FILE, *bss-backend-*:BACKEND_FILE, crm-cqrs-*:CRM_CQRS_FILE')
# 'BUILD_LIFERAY' determines which lar files, CRM.lar and/or Administration.lar, have to be build (acceptable values: CRM and/or Administration)
# 'CREATE_BUILD_VERSION' determines for which environments should be created build.ver to verify currently installed system version
# 'CRM_BACKUP' determines for which environments should be created backup of application (dependency with key 'HOT_DEPLOY')
# 'DATA_RETENTION' determines for which environments should be performed proper mechanism: remove obsolete files or archive logfiles (structure: <ENV>:archive_logs:remove_obsolete_files)
# 'DEFAULT_APPS' determines which applications are dafault for currently installed software (required by mubemanage script)
# 'ERROR_PRIORITY' determines for which envrionments should be checked deployment logfile with high sensitivity
# 'EXPIRE_TIME' determines in first column: time after which remove files from servers, in second: how many versions should be left on server, in third: how old logfiles should be archived
# 'FEATURE_BRANCH' determines if project supports feature branch (merging database to current and future versions)
# 'FOOTER' determines argument for remote command (version declaration for CRM footer in CRM 7.2 systems and below - acceptable string with variables)
# 'HOT_DEPLOY' determines softlink names for deployed applications - modified properties_config.xml file (second column: BSS, in third column: CRM, in fourth column: TUM, in fifth column: BPC, in sixth column: AIF)
# 'IMPLEMENTATION' determines publication check method based on logfiles (for systems 7.2 and lower - based on elasticsearch indexes, environments cannot be declared, default method)
# 'IMPLEMENTATION_METHOD' determines adapted methodology of implementation repository (TAGS or BRANCHES)
# 'IMPLEMENTATION_TAGS' determines names of tags for offer and business requests
# 'LOGS_DIR' determines location for application logs, if different than default (in second and further columns should be definied environments (the last column - custom path to logs)
# 'PROJECT_BRACH_PATTERN' determines branches pattern of implementation repository (key BRANCHES for IMPLEMENTATION_METHOD definition must be true)
# 'PROTECTED_ENVIRONMENTS' determines which environments should have be restricted in terms of applications administration
# 'RABBITMQ_TRESHOLD' determines value below which number of queued messages on stack is acceptable
# 'REQUIRED_JAVA' determines required Java binaries in first column (without dot in column, e.g. 17), second column: nodes on which should be checked (e.g. CPM|CRM|TUM), and in further columns: list of environments
# 'REQUIRED_LINUX_COMMANDS' determines which linux commands are essential for deployment handling
# 'SKIP_LIQUIBASES' determines environments for which should be skipped verification of liquibase installation (under consideration are taken only newest releases in branch)
# 'UPDATE_REPOSITORY' determines for which environments should be downloaded implementation part from local GIT repository (structure - <environment name>:<head folder name>)
# 'UPDATE_ZOOKEEPER_REPOSITORY' determines for which environments should be updated upstream repository (properties_config.xml file) - folder: ${LHOME}/${PROJECT}/bin/environments_configuration
# 'ZK_GIT' determines which environments do not exclude from downloading external configuration from GitLAB repository (suffix 'DOWNLOAD' or/and UPLOAD is mendatory)
# 'ZK_MERGE' determines in first column: branch from which configuration files should be downloaded, in second: head files storage, in third: merge task between remote repository and delivered package (key: MERGE_TRUE)
