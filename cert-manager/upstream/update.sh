#!/bin/bash

rm -fr upstream/helm/*

helm template cert-manager jetstack/cert-manager --set installCRDs=true --output-dir helm
mv helm/cert-manager/templates/* helm 
rm -fr helm/cert-manager

# Format helm templates for consistent diff
kpt cfg fmt helm