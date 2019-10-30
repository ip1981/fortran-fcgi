program fortran_fcgi

   use fcgi_protocol

   implicit none

   type(DICT_STRUCT), pointer :: dict => null()
   integer :: outUnit
   character(len=11) :: statusHeader
   integer :: statusCode
   integer :: rc

   outUnit = getpid()

   open (unit=outUnit, status='scratch')

   do while (fcgip_accept_environment_variables() >= 0)

      statusCode = 200
      call fcgip_make_dictionary(dict, outUnit)
      call respond(dict, statusCode, outUnit)
      write(statusHeader, '("Status: ", i3)') statusCode
      rc = fcgip_put_string(statusHeader//NUL)
      call fcgip_put_file(outUnit)

   end do

contains

   subroutine respond(dict, statusCode, outUnit)
      type(DICT_STRUCT), pointer, intent(in) :: dict
      integer, intent(out) :: statusCode
      integer, intent(in) :: outUnit
      character(len=80) :: scriptName

      call cgi_get(dict, 'DOCUMENT_URI', scriptName)

      select case (trim(scriptName))

         case ('/foo')
            write(outUnit, '(a)') scriptName
         case default
            statusCode = 404

      end select
   end subroutine respond

end program fortran_fcgi

