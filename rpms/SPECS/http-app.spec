Name: http-app
Version: 1.0
Release : %{?BUILD_NUMBER}
Summary: Simple HTTP app in Go
License: None
BuildRoot: %{_tmppath}/%{name}-%{version}-root

Requires: supervisor

%description
Simple HTTP app in Go

%prep

%build

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/local/bin %{buildroot}/etc/supervisord.d
cp ../SOURCES/http-app %{buildroot}/usr/local/bin/
cp ../SOURCES/http-app.ini %{buildroot}/etc/supervisord.d/
chmod 755 %{buildroot}/usr/local/bin/http-app
chmod 644 %{buildroot}/etc/supervisord.d/http-app.ini

%post
mkdir -p /var/log/http-app
/sbin/service supervisord restart

%files
%defattr(-, root, root)
/usr/local/bin/http-app
/etc/supervisord.d/http-app.ini

%changelog
* Tue Jun 21 2016 Tim Birkett - 1.0
- Initial package
