require "tty-table"

$big_chars = ("A".."Z").to_a + ("0".."9").to_a + %w( # $ % & ) + %w(九 七 二 人 入 八 力 十 下 三 千 上 口 土 夕 大 女 子 小 山 川 五 天 中 六 円 手)
$med_chars = %w(; < > * ! ? { } : - _ + =)
$sml_chars = %w(. , ` ' " ^ ~)

row1 = [" ", " ", " ", " ", " ", " ", " ", " "]
row2 = [" ", " ", " ", " ", " ", " ", " ", " "]
row3 = [" ", " ", " ", " ", " ", " ", " ", " "]
row4 = [" ", " ", " ", " ", " ", " ", " ", " "]
row5 = [" ", " ", " ", " ", " ", " ", " ", " "]
row6 = [" ", " ", " ", " ", " ", " ", " ", " "]
row7 = [" ", " ", " ", " ", " ", " ", " ", " "]
row8 = [" ", " ", " ", " ", " ", " ", " ", " "]
row9 = [" ", " ", " ", " ", " ", " ", " ", " "]
row10 = [" ", " ", " ", " ", " ", " ", " ", " "]
row11 = [" ", " ", " ", " ", " ", " ", " ", " "]

header = ["1", "2", "h3", "h4", "h5", "h6", "h7", "h8"]
header = %w(h e l l o nn ee oo)
# header = [" ", " ", " ", " ", " ", " ", " ", " "]
p header
$rows = [row1, row2, row3, row4, row5, row6, row7, row8, row9, row10, row11]
$lives = [36, 40, 46, 48, 54, 60]

column_picker = [0, 1, 2, 3, 4, 5, 6, 7]
snake1 = { row: rand(6..10), column: column_picker.delete(column_picker.sample), life: $lives.sample }
snake2 = { row: rand(6..10), column: column_picker.delete(column_picker.sample), life: $lives.sample }
snake3 = { row: rand(6..10), column: column_picker.delete(column_picker.sample), life: $lives.sample }
snake4 = { row: rand(6..10), column: column_picker.delete(column_picker.sample), life: $lives.sample }
snake5 = { row: rand(6..10), column: column_picker.delete(column_picker.sample), life: $lives.sample }

def matrix(snake)
  #resets the snake after it dies
  if snake[:life] == -2
    column_picker = [0, 1, 2, 3, 4, 5, 6, 7]
    snake[:life] = $lives.sample
    # snake[:column] = column_picker.delete_at(column_picker.sample)
    snake[:column] = column_picker.delete_at(column_picker.sample)
  end

  #generates the snake to make it seem like it's moving
  if snake[:life] > 36
  elsif snake[:life] > 30
    $rows[snake[:row]][snake[:column]] = $big_chars.sample
  elsif snake[:life] > 27
    $rows[snake[:row] - 0][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 1][snake[:column]] = $big_chars.sample
  elsif snake[:life] > 24
    $rows[snake[:row] - 0][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 1][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 2][snake[:column]] = $med_chars.sample
  elsif snake[:life] > 21
    $rows[snake[:row] - 0][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 1][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 2][snake[:column]] = $med_chars.sample
    $rows[snake[:row] - 3][snake[:column]] = $med_chars.sample
  elsif snake[:life] > 18
    $rows[snake[:row] - 0][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 1][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 2][snake[:column]] = $med_chars.sample
    $rows[snake[:row] - 3][snake[:column]] = $med_chars.sample
    $rows[snake[:row] - 4][snake[:column]] = $sml_chars.sample
  elsif snake[:life] > 15
    $rows[snake[:row] - 0][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 1][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 2][snake[:column]] = $med_chars.sample
    $rows[snake[:row] - 3][snake[:column]] = $med_chars.sample
    $rows[snake[:row] - 4][snake[:column]] = $sml_chars.sample
    $rows[snake[:row] - 5][snake[:column]] = $sml_chars.sample
  elsif snake[:life] > 12
    $rows[snake[:row] - 0][snake[:column]] = " "
    $rows[snake[:row] - 1][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 2][snake[:column]] = $med_chars.sample
    $rows[snake[:row] - 3][snake[:column]] = $med_chars.sample
    $rows[snake[:row] - 4][snake[:column]] = $sml_chars.sample
    $rows[snake[:row] - 5][snake[:column]] = $sml_chars.sample
  elsif snake[:life] - 0 > 9
    $rows[snake[:row] - 1][snake[:column]] = " "
    $rows[snake[:row] - 2][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 3][snake[:column]] = $med_chars.sample
    $rows[snake[:row] - 4][snake[:column]] = $sml_chars.sample
    $rows[snake[:row] - 5][snake[:column]] = $sml_chars.sample
  elsif snake[:life] > 6
    $rows[snake[:row] - 2][snake[:column]] = " "
    $rows[snake[:row] - 3][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 4][snake[:column]] = $sml_chars.sample
    $rows[snake[:row] - 5][snake[:column]] = $sml_chars.sample
  elsif snake[:life] > 3
    $rows[snake[:row] - 3][snake[:column]] = " "
    $rows[snake[:row] - 4][snake[:column]] = $big_chars.sample
    $rows[snake[:row] - 5][snake[:column]] = $sml_chars.sample
  elsif snake[:life] > 0
    $rows[snake[:row] - 4][snake[:column]] = " "
    $rows[snake[:row] - 5][snake[:column]] = $big_chars.sample
  else
    $rows[snake[:row] - 5][snake[:column]] = " "
  end
  snake[:life] -= 1
end

while true
  matrix(snake1)
  matrix(snake2)
  matrix(snake3)
  matrix(snake4)
  matrix(snake5)
  system("clear")
  table = TTY::Table.new(rows: $rows)
  puts table.render(:basic, column_widths: 2, alignment: [:center])

  sleep(0.05)
end
