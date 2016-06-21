Name: http-app
Version: 1.0
Release : %{?BUILD_NUMBER}
Summary: Simple HTTP app in Go
License: None

BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-%{version}-root

%description
Simple HTTP app in Go

%prep

%build

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/local/bin %{buildroot}/etc/init.d
cp ../SOURCES/http %{buildroot}/usr/local/bin/
chmod 755 %{buildroot}/usr/local/bin/http

%files
%defattr(-, root, root)
/usr/local/bin/http

%changelog
* Tue Jun 21 2016 Tim Birkett - 1.0
- Initial package
