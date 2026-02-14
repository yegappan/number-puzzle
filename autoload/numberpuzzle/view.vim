vim9script

# View module for popup-based puzzle rendering.
# Contains the view interface and popup implementation.

export interface IPuzzleView
  def Render(lines: list<string>)
endinterface


export class PopupView implements IPuzzleView
  var id: number

  def new()
    this.id = 0
  enddef

  def Render(lines: list<string>)
    if this.id == 0 || empty(popup_getpos(this.id))
      var width = 0
      for line in lines
        if strdisplaywidth(line) > width
          width = strdisplaywidth(line)
        endif
      endfor
      var height = len(lines)
      this.id = popup_create(lines, {
        pos: 'center',
        minwidth: width,
        maxwidth: width,
        minheight: height,
        maxheight: height,
        title: 'Puzzle',
        wrap: 0,
        padding: [0, 0, 0, 0],
        border: [],
        mapping: 0,
      })
    else
      popup_settext(this.id, lines)
      var width = 0
      for line in lines
        if strdisplaywidth(line) > width
          width = strdisplaywidth(line)
        endif
      endfor
      var height = len(lines)
      popup_setoptions(this.id, {
        minwidth: width,
        maxwidth: width,
        minheight: height,
        maxheight: height,
        title: 'Puzzle',
      })
    endif
  enddef

  def GetId(): number
    return this.id
  enddef

  def Close()
    if this.id != 0
      popup_close(this.id)
      this.id = 0
    endif
  enddef

  def IsOpen(): bool
    return this.id != 0 && !empty(popup_getpos(this.id))
  enddef
endclass
