require 'fileutils'
require 'strscan'

IGNORED_HEADERS = [
  'headers/SDL_main.h'
]

K = {
  'SDL_TEXTEDITINGEVENT_TEXT_SIZE'    => 32,
  'SDL_TEXTINPUTEVENT_TEXT_SIZE'      => 32
}

# List the names of any functions for which c-lambdas should not
# be automatically generated here.
IGNORED_FUNCTIONS = [
  'SDL_AndroidGetInternalStoragePath',
  'SDL_AndroidGetExternalStorageState',
  'SDL_AndroidGetExternalStoragePath',
  'SDL_Direct3D9GetAdapterIndex',
  'SDL_iPhoneSetEventPump',
  'SDL_malloc',
  'SDL_calloc',
  'SDL_realloc',
  'SDL_free',
  'SDL_memset',
  'SDL_memcpy',
  'SDL_memmove',
  'SDL_memcmp',
  'SDL_sscanf',
  'SDL_snprintf',
  'SDL_vsnprintf'
]

INCLUDED_STRUCTS = %w(
  SDL_CommonEvent
  SDL_WindowEvent
  SDL_KeyboardEvent
  SDL_TextEditingEvent
  SDL_TextInputEvent
  SDL_MouseMotionEvent
  SDL_MouseButtonEvent
  SDL_MouseWheelEvent
  SDL_JoyAxisEvent
  SDL_JoyBallEvent
  SDL_JoyHatEvent
  SDL_JoyButtonEvent
  SDL_JoyDeviceEvent
  SDL_ControllerAxisEvent
  SDL_ControllerButtonEvent
  SDL_ControllerDeviceEvent
  SDL_TouchFingerEvent
  SDL_MultiGestureEvent
  SDL_DollarGestureEvent
  SDL_DropEvent
  SDL_QuitEvent
  SDL_OSEvent
  SDL_UserEvent
  SDL_SysWMEvent
  SDL_Keysym
  SDL_Color
  SDL_Palette
  SDL_PixelFormat
  SDL_Point
  SDL_Rect
  SDL_RendererInfo
  SDL_Surface
  SDL_DisplayMode
)

TYPES = {
    
    'void' => {
      :gambit => 'void'
    },

    'int' => {
      :gambit => 'int'
    },

    'double' => {
      :gambit => 'double'
    },

    'float' => {
      :gambit => 'float'
    },

    'char*' => {
      :gambit => 'char-string'
    },

    'const char*' => {
      :gambit => 'char-string'
    },

    'size_t' => {
      :gambit => 'size_t'
    },

    'long' => {
      :gambit => 'long'
    },

    'unsigned int' => {
      :gambit => 'unsigned-int'
    },

    'unsigned long' => {
      :gambit => 'unsigned-long'
    },

    #
    #

    'Uint64' => {
      :gambit => 'Uint64',
      :declare_as => 'unsigned-int64'
    },

    'Uint32' => {
      :gambit => 'Uint32',
      :declare_as => 'unsigned-int32'
    },

    'Uint16' => {
      :gambit => 'Uint16',
      :declare_as => 'unsigned-int16'
    },

    'Uint8' => {
      :gambit => 'Uint8',
      :declare_as => 'unsigned-int8'
    },

    'Sint64' => {
      :gambit => 'Sint64',
      :declare_as => 'int64'
    },

    'Sint16' => {
      :gambit => 'Sint16',
      :declare_as => 'int16'
    },

    'SDL_bool' => {
      :gambit => 'SDL_bool',
      :declare_as => 'int'
    },

    'SDL_AudioDeviceID' => {
      :gambit => 'SDL_AudioDeviceID',
      :declare_as => 'Uint32'
    },

    'SDL_JoystickID' => {
      :gambit => 'SDL_JoystickID',
      :declare_as => 'int32'
    },

    'SDL_TimerID' => {
      :gambit => 'SDL_TimerID',
      :declare_as => 'int'
    },

    'SDL_TouchID' => {
      :gambit => 'SDL_TouchID',
      :declare_as => 'int64'
    },

    'SDL_FingerID' => {
      :gambit => 'SDL_FingerID',
      :declare_as => 'int64'
    },

    'SDL_GestureID' => {
      :gambit => 'SDL_GestureID',
      :declare_as => 'int64'
    },

    'SDL_threadID' => {
      :gambit => 'SDL_threadID',
      :declare_as => 'unsigned-long'
    },

    'SDL_AudioFormat' => {
      :gambit => 'SDL_AudioFormat',
      :declare_as => 'Uint16'
    },

    'SDL_Keycode' => {
      :gambit => 'SDL_Keycode',
      :declare_as => 'int32'
    },

    'SDL_TLSID' => {
      :gambit => 'SDL_TLSID',
      :declare_as => 'unsigned-int'
    },

    #
    # Enums

    'SDL_GameControllerAxis' => { :gambit => 'int' },
    'SDL_GameControllerBindType' => { :gambit => 'int' },
    'SDL_GameControllerButton' => { :gambit => 'int' },
    'SDL_Scancode' => { :gambit => 'int' },
    'SDL_ThreadPriority' => { :gambit => 'int' },
    'SDL_errorcode' => { :gambit => 'int' },
    'SDL_RendererFlip' => { :gambit => 'int' },
    'SDL_TextureModulate' => { :gambit => 'int' },
    'SDL_TextureAccess' => { :gambit => 'int' },
    'SDL_BlendMode' => { :gambit => 'int' },
    'SDL_SystemCursor' => { :gambit => 'int' },
    'SDL_Keymod' => { :gambit => 'int' },
    'SDL_PowerState' => { :gambit => 'int' },
    'Mix_Fading' => { :gambit => 'int' },
    'Mix_MusicType' => { :gambit => 'int' },
    'SDL_eventaction' => { :gambit => 'int' },
    'SDL_HintPriority' => { :gambit => 'int' },
    'SDL_AudioStatus' => { :gambit => 'int' },

    #
    # Pointers

    'SDL_RendererInfo*' => {
      :gambit => 'sdl::renderer-info-ptr',
      :declare_as => '(pointer "SDL_RendererInfo")'
    },
    
    'SDL_Window*' => {
      :gambit => 'sdl::window-ptr',
      :declare_as => '(pointer "SDL_Window")'
    },
    
    'SDL_Renderer*' => {
      :gambit => 'sdl::renderer-ptr',
      :declare_as => '(pointer "SDL_Renderer")'
    },
    
    'SDL_Surface*' => {
      :gambit => 'sdl::surface-ptr',
      :declare_as => '(pointer "SDL_Surface")'
    },
    
    'SDL_Texture*' => {
      :gambit => 'sdl::texture-ptr',
      :declare_as => '(pointer "SDL_Texture")'
    },

    'SDL_Cursor*' => {
      :gambit => 'sdl::cursor-ptr',
      :declare_as => '(pointer "SDL_Cursor")'
    },

    'TTF_Font*' => {
      :gambit => 'sdl::ttf-font-ptr',
      :declare_as => '(pointer "TTF_Font")'
    },

    'SDL_Thread*' => {
      :gambit => 'sdl::thread-ptr',
      :declare_as => '(pointer "SDL_Thread")'
    },

    'SDL_RWops*' => {
      :gambit => 'sdl::rw-ops-ptr',
      :declare_as => '(pointer "SDL_RWops")'
    },

    'SDL_Haptic*' => {
      :gambit => 'sdl::haptic-ptr',
      :declare_as => '(pointer "SDL_Haptic")'
    },

    'SDL_Joystick*' => {
      :gambit => 'sdl::joystick-ptr',
      :declare_as => '(pointer "SDL_Joystick")'
    },

    'SDL_GameController*' => {
      :gambit => 'sdl::game-controller-ptr',
      :declare_as => '(pointer "SDL_GameController")'
    },    
    

    #
    # Unsupported
}

#
#

$skipped_defs   = [] # deifinitions that were skipped outright
$unknown_types  = {}
$skipped_fns    = []

$functions = File.open(File.dirname(__FILE__) + '/../src/lib/sdl2/functions.scm', 'w')
$functions.puts "; This file is automatically generated"
$functions.puts "; (see binding-generator/gen.rb)"
$functions.puts ""

$structs = File.open(File.dirname(__FILE__) + '/../src/lib/sdl2/structs.scm', 'w')
$structs.puts "; This file is automatically generated"
$structs.puts "; (see binding-generator/gen.rb)"
$structs.puts ""

#
#

class FileLines
  def initialize(src)
    @lines = src.split("\n")
    @ix = 0
  end

  def next_line
    if @ix == @lines.length
      nil
    else
      line = @lines[@ix]
      @ix += 1
      line
    end
  end
end

def name_to_scheme(name)
  name.gsub(/^SDL_/, '')
      .gsub(/([A-Z]{2,}?)([A-Z][a-z])/, '\\1_\\2')
      .gsub(/_/, '-')
      .gsub(/([^A-Z])([A-Z])/, '\\1-\\2')
      .gsub(/-+/, '-')
      .downcase
      .gsub(/sdl-net/, 'net')
end

def gambit_type(c_type, direction)
  entry = TYPES[c_type]
  if !entry
    $unknown_types[c_type] ||= {}
    $unknown_types[c_type][direction] = true
    nil
  else
    entry[:gambit]
  end
end

def generate_types
  File.open(File.dirname(__FILE__) + '/../src/lib/sdl2/types.scm', 'w') do |f|
    TYPES.each do |k,v|
      if v[:declare_as]
        f.puts "(c-define-type"
        f.puts "    #{v[:gambit]}"
        f.puts "    #{v[:declare_as]})"
        f.puts ""
      end
    end
  end
end

def process(file)
  lines = FileLines.new(File.read(file))
  while (line = lines.next_line)
    if line =~ /SDLCALL/
      fndef = line
      while line !~ /\)\s*;/
        fndef += (line = lines.next_line)
      end

      # there is no science behind this; it's completely ad-hoc based
      # on observations of the SDL source.
      fndef = fndef.gsub('SDLCALL', '')
                   .gsub(/^\s*extern DECLSPEC /, '')
                   .gsub(/\s+\*\s+/, '*')             # "  *  " => "*"
                   .gsub(/\*([^\*])/, '* \\1')        # "*foo"  => "* foo"
                   .gsub(/\s+\*/, '*')                # " *"    => "*"
                   .gsub(/\s+\(/, '(')                # "  ("   => "("
                   .gsub(/\s+/, ' ')                  # "   "   => " "
                   .strip

      next if fndef =~ /typedef/

      if fndef =~ /^(((const|unsigned) )?([^\s]+)) (\w+)\(([^\)]*)\);$/
        return_type, name, args = $1, $5, $6

        next if IGNORED_FUNCTIONS.include?(name)

        return_type = gambit_type(return_type, :return)

        arg_types = args.split(',').map(&:strip).map { |a| a.gsub(/ \w+$/, '').gsub(/^const /, '') }
        arg_types = arg_types.map { |at| gambit_type(at, :arg) }

        if arg_types.length == 1 && arg_types[0] == 'void'
          arg_types = []
        end

        gambit_name = name_to_scheme(name)

        gambit_name = 'sdl::' + gambit_name

        if return_type && arg_types.all?
          $functions.puts "(define #{gambit_name}"
          $functions.puts "    (c-lambda (#{arg_types.join(' ')}) #{return_type}"
          $functions.puts "        \"#{name}\"))"
          $functions.puts ""
        else
          $skipped_fns << fndef
        end
      
      else
        $skipped_defs << fndef
      end
    elsif line =~ /typedef struct (\w+)/
      next unless INCLUDED_STRUCTS.include?($1)

      struct, struct_ok = "(c-define-struct #{$1}\n", true

      # this is (maybe) a vaguely sensible struct-member parser.
      while ((line = lines.next_line) !~ /\}/)
        if line =~ /;/
          scanner = StringScanner.new(line)
          type, pointer, name, array_len = [], 0, [], nil
          while (ident = scanner.scan(/\s*\w+/))
            type << ident.strip
          end
          if (star = scanner.scan(/\s*\*/))
            pointer = 1
            while (star = scanner.scan(/\s*\*/))
              pointer += 1
            end
            name.push(scanner.scan(/\s*\w+/).strip)
          else
            name.push(type.pop)
          end
          while (scanner.scan(/\s*,\s*/))
            name.push(scanner.scan(/\w+/))
          end
          if scanner.scan(/\s*\[([^\]]+)\]/)
            array_len = K[scanner[1]] || scanner[1].to_i
          end
          if scanner.scan(/\s*;/)
            if array_len
              puts "whoops, arrays not yet supported!"
              struct_ok = false
            else
              name.each do |n|
                struct << "    (#{name_to_scheme(n)} #{type.join(' ')}#{'*' * pointer})\n"
              end
            end
          else
            puts "fail: #{line}"
            struct_ok = false
          end
        end
      end

      if struct_ok
        $structs << struct.rstrip << ")\n\n"
      end

    end
  end
end

generate_types
Dir['headers/*.h'].each do |s|
  next if IGNORED_HEADERS.include?(s)
  process(s)
end

puts "Skipped entirely, because I'm too simple to parse them:"
$skipped_defs.each { |d| puts "    #{d}" }
puts

puts "Skipped because parameter types are unsupported:"
$skipped_fns.each { |d| puts "    #{d}" }
puts

if $unknown_types.size > 0
  puts "Uknown types:"
  $unknown_types.each do |type,dirs|
    puts "    #{type} (#{dirs.keys.sort.map(&:to_s).join(',')})"
  end
  puts
end