#the code will be generated with this table, going down the 'columns'
require "tty-table"

#these are the pools the characters can pull from
$code = ("A".."Z").to_a + ("0".."9").to_a + %w( # $ % & ) + %w(九 七 二 人 入 八 力 十 下 三 千 上 口 土 夕 大 女 子 小 山 川 五 天 中 六 円 手)

#these generate all the rows for the table
$rows = [
  row1 = Array.new(15, " "),
  row2 = Array.new(15, " "),
  row3 = Array.new(15, " "),
  row4 = Array.new(15, " "),
  row5 = Array.new(15, " "),
  row6 = Array.new(15, " "),
  row7 = Array.new(15, " "),
  row8 = Array.new(15, " "),
  row9 = Array.new(15, " "),
  row10 = Array.new(15, " "),
  row11 = Array.new(15, " "),
  row12 = Array.new(15, " "),
  row13 = Array.new(15, " "),
  row14 = Array.new(15, " "),
  row15 = Array.new(15, " "),
  row16 = Array.new(15, " "),
  row17 = Array.new(15, " "),
  row18 = Array.new(15, " "),
  row19 = Array.new(15, " "),
  row20 = Array.new(15, " "),
]
$rows = [row1, row2, row3, row4, row5, row6, row7, row8, row9, row10, row11, row12, row13, row14, row15, row16, row17, row18, row19, row20]

#this is just a way to make the code snakes spawn at different intervals

$columns = Array.new(15, 0).map.with_index { |number, index| number + index }
$column_test = 0

#these are the matrix code thingies
snakes = [
  snake1 = { row: 0, column: $columns.delete($columns.sample) },
  snake2 = { row: 0 - 3, column: $columns.delete($columns.sample) },
  snake3 = { row: 0 - 6, column: $columns.delete($columns.sample) },
  snake4 = { row: 0 - 9, column: $columns.delete($columns.sample) },
  snake5 = { row: 0 - 14, column: $columns.delete($columns.sample) },
  snake7 = { row: 0 - 17, column: $columns.delete($columns.sample) },
  snake8 = { row: 0 - 19, column: $columns.delete($columns.sample) },
  snake9 = { row: 0 - 21, column: $columns.delete($columns.sample) },
  snake10 = { row: 0 - 23, column: $columns.delete($columns.sample) },
  snake11 = { row: 0 - 26, column: $columns.delete($columns.sample) },
  snake12 = { row: 0 - 29, column: $columns.delete($columns.sample) },
  snake12 = { row: 0 - 34, column: $columns.delete($columns.sample) },
]

snakes.each { |snake| snake[:occupied_column] = snake[:column] }

#green-ify's the text
class String
  def green
    "\e[2;32m#{self}\e[0m"
  end

  def bright_green
    "\e[1;32m#{self}\e[0m"
  end
end

def do_nothing
end

#this is the code generation method. It's pretty janky because of all the nil checks..
def matrix(snake)

  #resets the snake up to the top
  if snake[:row] == 47
    snake[:row] = 0

    snake[:column] = $columns.delete($columns.sample)
    snake[:occupied_column] = snake[:column]

    #delete old code, and allows the column to be ripe for another snake
  elsif snake[:row] > 22
    $rows[snake[:row]][snake[:column]] = $code.sample if $rows[snake[:row]] != nil || do_nothing()
    $rows[snake[:row] - 13][snake[:column]] = $rows[snake[:row] - 13][snake[:column]].green if $rows[snake[:row] - 13] != nil || do_nothing()
    $rows[snake[:row] - 23][snake[:column]] = " " if $rows[snake[:row] - 23] != nil || do_nothing()
    $columns << snake[:occupied_column]

    #random glitch
  elsif snake[:row] == 16
    $rows[snake[:row]][snake[:column]] = $code.sample if $rows[snake[:row]] != nil || do_nothing()
    $rows[snake[:row] - 1][snake[:column]] = $rows[snake[:row] - 1][snake[:column]].bright_green if $rows[snake[:row] - 1] != nil || do_nothing()
    $rows[snake[:row] - 13][snake[:column]] = $rows[snake[:row] - 13][snake[:column]].green if $rows[snake[:row] - 13] != nil || do_nothing()
    $rows[snake[:row] - 8][snake[:column]] = $code.sample.bright_green if $rows[snake[:row] - 8] != nil || do_nothing()
  elsif snake[:row] == 19
    $rows[snake[:row]][snake[:column]] = $code.sample if $rows[snake[:row]] != nil || do_nothing()
    $rows[snake[:row] - 1][snake[:column]] = $rows[snake[:row] - 1][snake[:column]].bright_green if $rows[snake[:row] - 1] != nil || do_nothing()
    $rows[snake[:row] - 13][snake[:column]] = $rows[snake[:row] - 13][snake[:column]].green if $rows[snake[:row] - 13] != nil || do_nothing()
    $rows[snake[:row] - 2][snake[:column]] = $code.sample.bright_green if $rows[snake[:row] - 2] != nil || do_nothing()

    #darken the old code
  elsif snake[:row] > 12
    $rows[snake[:row]][snake[:column]] = $code.sample if $rows[snake[:row]] != nil || do_nothing()
    $rows[snake[:row] - 1][snake[:column]] = $rows[snake[:row] - 1][snake[:column]].bright_green if $rows[snake[:row] - 1] != nil || do_nothing()
    $rows[snake[:row] - 13][snake[:column]] = $rows[snake[:row] - 13][snake[:column]].green if $rows[snake[:row] - 13] != nil || do_nothing()

    #change the code to bright green
  elsif snake[:row] >= 0
    $rows[snake[:row]][snake[:column]] = $code.sample
    $rows[snake[:row] - 1][snake[:column]] = $rows[snake[:row] - 1][snake[:column]].bright_green
  end
  #sets the new row to one more down, before the next loop
  snake[:row] += 1
end

#this is the main loop, which runs forever
while true
  snakes.each { |snake| matrix(snake) }
  system("clear")
  table = TTY::Table.new(rows: $rows)
  puts table.render(:basic, column_widths: 2, alignment: [:center])
  sleep(0.03)
end
