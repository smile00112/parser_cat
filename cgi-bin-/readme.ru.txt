Apache Win32, CGI:
-----------------
�������� � �������� �������� ������ ������� ���� .htaccess 
� �������� � ���� ��������� �������:

# ���������� ������������ .html �������:
AddHandler parsed-html html
Action parsed-html /cgi-bin/parser3.exe


# ������ �� ������ � .cfg � .p ������:
<Files ~ "\.(p|cfg)$">
Order allow,deny
Deny from all
</Files>

����� �������� ��� ���� �������:

CharsetDisable On

���� ���������� ���� ������� ������� � ������, ������ ��� ���-������ 
�� ��������� � ���� �������������� ���������.

��-���������, � ��������� Apache ����������� ������������� .htaccess ���������.

Internet Information Server 4�5 (Win32):
---------------------------------------

��������� Management Console, ������� ������ ������ ���� �� �������� 
������ ���-������� � �������� "Properties".

��������� �� ������� �Home directory� � � ������� �Application settings� 
������� �� ������ �Configuration...�. � ����������� ���� ������� �� ������ �Add�.

� ���� �Executable� ������� ������ ���� � CGI-������� parser3.exe 
� ���� �Extension� ������� �.html�.
�������� ����� �Check that file exists�.
������� �� ������ �OK�.

Parser ����� ����� ���������� �� IIS 2 � �� Personal Web Server, 
�������� ������������ ������ *.html CGI-������ parser3.exe.

����� ����������� ������������ � ���������� �� ������������ IIS:
http://support.microsoft.com/support/kb/articles/Q260/0/69.ASP