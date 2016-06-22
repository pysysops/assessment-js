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
mkdir -p %{buildroot}/usr/local/bin %{buildroot}/etc/supervisor.d/
cp ../SOURCES/http-app %{buildroot}/usr/local/bin/
cp ../SOURCES/http-app.ini %{buildroot}/etc/supervisor.d/
chmod 755 %{buildroot}/usr/local/bin/http-app
chmod 644 %{buildroot}/etc/supervisor.d/http-app.ini

%post
/sbin/service supervisord restart

%files
%defattr(-, root, root)
/usr/local/bin/http-app
/etc/supervisor.d/http-app.ini

%changelog
* Tue Jun 21 2016 Tim Birkett - 1.0
- Initial package
