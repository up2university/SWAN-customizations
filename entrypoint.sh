#!/bin/bash
set -o errexit # Bail out on all errors immediately

echo ""
echo "Applying customizations for Up2U..."

### 1. Put in place the Up2U logo
echo "  .Logo ..."
mv /srv/jupyterhub/logo/logo_swan_cloudhisto.png /srv/jupyterhub/logo/logo_swan_cloudhisto.png.original
cp up2u_logo.png /srv/jupyterhub/logo/logo_swan_cloudhisto.png

echo "Done"
echo ""

