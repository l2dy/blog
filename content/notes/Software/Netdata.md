## Disable Telemetry and Cloud Features

```bash
cat > ~/cloud.conf << EOF
[global]
  enabled = no
EOF

sudo cp ~/cloud.conf /var/lib/netdata/cloud.d/
sudo touch /etc/netdata/.opt-out-from-anonymous-statistics
```

## How to build RPM packages

https://github.com/netdata/netdata/blob/v1.39.0/packaging/building-native-packages-locally.md

`:z` is needed if SELinux is enabled. Use `:Z` for additional access protection.

```sh
git clone https://github.com/netdata/netdata.git
cd netdata

git apply <<'EOF'
diff --git a/netdata.spec.in b/netdata.spec.in
index c2fa7dcab..f70f74c6c 100644
--- a/netdata.spec.in
+++ b/netdata.spec.in
@@ -231,6 +231,7 @@ export CFLAGS="${CFLAGS} -fPIC" && ${RPM_BUILD_DIR}/%{name}-%{version}/packaging
 # Conf step
 autoreconf -ivf
 %configure \
+	--disable-cloud \
 	%if 0%{!?_have_ebpf}
 	--disable-ebpf
 	%endif
EOF

podman run -it --rm -e VERSION=<1.x.x> -v $PWD:/netdata:z netdata/package-builders:oraclelinux9
# checking if Cloud functionality should be enabled... no
```

## Charts v3

> These are currently available at Netdata Cloud. At the next Netdata release (v1.40.0), the agent dashboard will be replaced to also use the same charts.