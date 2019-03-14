#!/bin/bash
set -o errexit # Bail out on all errors immediately

echo ""
echo "Applying customizations for Up2U..."

### 1. Put in place the Up2U logo
#echo "  .Logo ..."
#mv /srv/jupyterhub/logo/logo_swan_cloudhisto.png /srv/jupyterhub/logo/logo_swan_cloudhisto.png.original
#cp up2u_logo.png /srv/jupyterhub/logo/logo_swan_cloudhisto.png

### 2. Set Up2U Single Sign-On paramters
# NOTE: Please select 'shibboleth' as authentication method ('AUTH_TYPE') for jupyterhub Docker image v0.6 and later
echo "  .SSO Configuration..."
cp sso_config/attribute-map.xml /etc/shibboleth/attribute-map.xml
sed "s/%%%HOSTNAME%%%/${HOSTNAME}/" sso_config/shibboleth2.xml.template > sso_config/shibboleth2.xml
cp sso_config/shibboleth2.xml /etc/shibboleth/shibboleth2.xml
sed -i "s/%%%SHIBBOLETH_AUTHENTICATOR_CLASS%%%/ssotoldap_authenticator.ssotoldap_user_auth.SSOUserAuthenticator/" /srv/jupyterhub/jupyterhub_config.py
###sed -i "s/%%%SHIBBOLETH_AUTHENTICATOR_CLASS%%%/ssoremoteuser_authenticator.sso_remote_user_auth.RemoteUserAuthenticator/" /srv/jupyterhub/jupyterhub_config.py

### 3. Add tracking code
sed -i "s/<\/body>/<script type=\"application\/javascript\" src=\"https:\/\/cdn.test.up2university.eu\/scripts\/matomo-test.js\"><\/script><\/body>/" /srv/jupyterhub/jh_gitlab/templates/page.html

### 4. Show a meaninfull message when users are denied starting SWAN 
echo "{% extends \"error.html\" %}{% block error_detail %}<p>You don't seem to have permission to use SWAN.</p><p>Did you create a CERNBox account? <a href=\"https://$CERNBOXGATEWAY_HOSTNAME\">You need to do it first.</a></p>{% endblock %}" > /srv/jupyterhub/jh_gitlab/templates/403.html

echo "Done"
echo ""

