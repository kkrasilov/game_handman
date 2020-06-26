class FilmEvening
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
    # Переводим все буквы ё, й - в загаданном слове в "нормальый" вид.
    @normalized_letters = normalized_letters(@letters)
  end

  def errors
    return @user_guesses - @normalized_letters
  end

  def errors_made
    return errors.length
  end

  def errors_allowed
    return TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =
        @letters.map do |letter|
          normalize_letter = normalize_letter(letter)
          if @user_guesses.include?(normalize_letter)
            letter
          else
            nil
          end
        end

    return result
  end

  def normalize_letter(char) # Метод меяет буквы: ё - е, й - и.
    case char
    when 'Ё' then 'Е'
    when 'Й' then 'И'
    else char
    end
  end

  def normalized_letters(letters) # Метод меняет все буквы ё и й в слове
    letters.map { |char| normalize_letter(char) }
  end

  def lost?
    return errors_allowed == 0
  end

  def over?
    return won? || lost?
  end

  def play!(letter)
    normalize_letter = normalize_letter(letter)
    if !over? && !@user_guesses.include?(normalize_letter)
      @user_guesses << normalize_letter
    end
  end

  def won?
    return (@normalized_letters - @user_guesses).empty?
  end

  def word
    return @letters.join
  end
end
