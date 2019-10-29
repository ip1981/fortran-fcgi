program fortran_fcgi

   use fcgi_protocol

   implicit none

   type(DICT_STRUCT), pointer :: dict => null()
   integer :: unitNo ! unit number  for a scratch file

   unitNo = getpid() ! use process ID as unit number
   open (unit=unitNo, status='scratch')

   do while (fcgip_accept_environment_variables() >= 0)

      call fcgip_make_dictionary(dict, unitNo)
      call respond(dict, unitNo)
      call fcgip_put_file(unitNo)

   end do

   close (unitNo)

contains

   subroutine respond(dict, unitNo)
      type(DICT_STRUCT), pointer, intent(in) :: dict
      integer, intent(in) :: unitNo
      character(len=80) :: scriptName

      write (unitNo, '(a)') &
         '<!DOCTYPE html>', &
         '<html lang="en">', &
         '<head><meta charset="utf-8" />', &
         '<title>Fortran FastCGI</title></head>', &
         '<body>', &
         '<h1>Fortran FastCGI</h1>'

      call cgi_get(dict, 'DOCUMENT_URI', scriptName)

      select case (trim(scriptName))

         case ('/foo')
            write (unitNo, '(a)') '<p>foo</p>'

      end select

      write (unitNo, '(a)') '</body>', '</html>'

   end subroutine respond

end program fortran_fcgi

