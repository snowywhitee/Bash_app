# ITMO OS 3 sem L1

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#task">Task</a>
      <ul>
        <li><a href="#recommendations">Recommendations</a></li>
      </ul>
    </li>
    <li><a href="#description">Description</a></li>
  </ol>
</details>

## Task

Лабораторная работа №1. Основы использования shell скриптов.

Задание на лабораторную работу:

* Выберите shell-интерпретатор и изучите его документацию (рекомендуется bash);
Используя язык интерпретатора *sh (bash, zsh, ksh, fish, и т.д.) разработайте приложение, соответствующее следующим требованиям:
приложение принимает набор параметров запуска (ключей), определяющих его работу;

  * в случае, если первым аргументом передан ключ **calc**, приложение выполняет функции калькулятора. 
  
    * Если вторым аргументом передан ключ **sum/sub/mul/div**, приложение выводит на экран сумму/разность/произведение/частное третьего и четвертого аргумента, являющихся целыми числами;
  
  * в случае, если первым аргументом передан ключ **search**, приложение производит рекурсивный поиск по содержимому файлов в директории, указанной вторым аргументом, и выводит на экран строки в соответствии с регулярным выражением, заданным третьим аргументом;
  
  * в случае, если первым аргументом передан ключ **reverse**, приложение в обратном порядке записывает содержимое файла, имя которого задано вторым аргументом, в файл с именем, переданным третьим аргументом;
  
  * в случае, если первым аргументом передан ключ **strlen**, приложение должно вывести количество символов в строке, переданной вторым аргументом. Использовать команду wc и циклы запрещено;
  
  * в случае, если первым аргументом передан ключ **log**, приложение должно вывести строки файла /var/log/anaconda/X.log, содержащие предупреждения и информационные сообщения, заменив маркеры предупреждений и информационных сообщений на слова Warning: и Information:, чтобы в получившемся файле сначала шли все предупреждения, а потом все информационные сообщения. При выводе на экран слово Warning вывести желтым цветом, слово Information — голубым цветом;
  
  * в случае, если первым аргументом передан ключ **exit**, приложение завершает свою работу с кодом возврата, заданным вторым параметром. Если код возврата не задан, по умолчанию используется 0;
  
  * в случае, если первым аргументом передан ключ **help**, приложение выводит справку по использованию, в которой перечислены все действия и их аргументы;
  
  * в случае, если первым аргументом передан ключ **interactive**, приложение переходит в интерактивный режим работы, предоставляя пользователю интерактивное меню с выбором действий:
пункты меню обозначены буквами, выбор действия осуществляется вводом соответствующей буквы или названия действия; после выбора действия пользователю предлагается ввести аргументы; допускается реализация как единого приглашения для ввода всех аргументов в строку, так и запрос каждого аргумента команды по отдельности;
после выполнения действия, приложение возвращается в меню; пункты меню соответствуют действиям не интерактивного режима (calc, search, reverse, exit и т.д.);

* приложение должно быть разделено на несколько взаимодействующих модулей (скриптов), соответственно выполняемым ими задачам;

* при разработке приложения необходимо руководствоваться здравым смыслом, принципами единой ответственности и переиспользования кода;

* приложение должно корректно обрабатывать исключительные ситуации:

  * при вводе некорректного имени действия должно выводиться сообщение об ошибке и справка по использованию приложения;
  
  * при вводе некорректного значения аргумента должно выводиться сообщение об ошибке с объяснением причины;

  * при возникновении исключительных ситуаций при работе вызываемых программ, сообщения об ошибках, произошедших в процессе их работы, не должны выводиться пользователю; приложение должно обработать возникающие ошибки, и, если ошибка является критической, выдать пользователю сообщение об ошибке с описанием ее причины;

  * в случае, если ошибка произошла в интерактивном режиме, выдается сообщение об ошибке, как описано выше, и приложение возвращается в меню;
  
  * в случае, если нарушена целостность приложения, и отсутствует часть его скриптов, при запуске должно быть выдано предупреждение о том, какие скрипты недоступны; если отсутствующие скрипты не являются критически важными для работы остальной части приложения, приложение продолжает работу;

  * в случае, если часть функций приложения недоступна из-за отсутствия модулей, допускаются следующие реализации: 

    * При попытке вызова недоступного действия в неинтерактивном режиме пользователю выдается сообщение ошибке. При работе в интерактивном режиме пользователю не предлагается вызов недоступного действия. При загрузке приложения в интерактивном режиме выдается сообщение о недоступности действий и причинах этого;

    * При попытке вызова недоступного действия в неинтерактивном режиме пользователю выдается сообщение ошибке. При работе в интерактивном режиме пользователю предлагается выполнение действия, однако при попытке его вызова выдается сообщение об ошибке. При загрузке приложения в интерактивном режиме выдается сообщение о недоступности действий и причинах произошедшего.
    * при возникновении критической ситуации в приложении, оно должно выдавать сообщение об ошибке, и происходить завершение приложения с отрицательным кодом возврата;
значение и описание кодов возврата должно быть описано в **help**.
  * Все сообщения об ошибках должны выводиться в стандартный поток ошибок (stderr).
* Опубликуйте результаты работы в публичном репозитории.

### Recommendations

* Структурируйте код скрипта: используйте функции, разбивайте приложение на отдельные файлы.

* Используйте конвейеры.

* Используйте сокращенную запись условий ([[ $a -eq $b]] && doThen || doElse).

* Пишите комментарии: вам проще разрабатывать, преподавателю проще проверять.

* Не забывайте поэтапно выкладывать результаты работы на GitHub. В случае списывания с вашей работы, коммиты будут весомым доказательством самостоятельности выполнения работы;

* Не забывайте писать шебанг (#!) в начале скриптов (напр, #!/bin/bash).


## Description

Для интерактивного режима использовался ncurses dialog (требуется предварительно отдельно установить).

Список команд в help.txt
