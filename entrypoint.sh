#!/bin/bash
set -o errexit # Bail out on all errors immediately

echo ""
echo "Applying customizations for Up2U..."

### 1. Put in place the Up2U logo
echo "  .Logo ..."
mv /srv/jupyterhub/logo/logo_swan_cloudhisto.png /srv/jupyterhub/logo/logo_swan_cloudhisto.png.original
cp up2u_logo.png /srv/jupyterhub/logo/logo_swan_cloudhisto.png

### 2. Set Up2U Single Sign-On paramters
# NOTE: Please select 'shibboleth' as authentication method ('AUTH_TYPE') for jupyterhub Docker image v0.6 and later
echo "  .SSO Configuration..."
cp sso_config/attribute-map.xml /etc/shibboleth/attribute-map.xml
sed "s/%%%HOSTNAME%%%/${HOSTNAME}/" sso_config/shibboleth2.xml.template > sso_config/shibboleth2.xml
cp sso_config/shibboleth2.xml /etc/shibboleth/shibboleth2.xml
sed -i "s/%%%SHIBBOLETH_AUTHENTICATOR_CLASS%%%/webtounix_authenticator.webtounix_user_auth.SSOUserAuthenticator/" /srv/jupyterhub/jupyterhub_config.py

echo "Done"
echo ""

