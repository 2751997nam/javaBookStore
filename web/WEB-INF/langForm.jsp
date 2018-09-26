<form action="LangController">
    <select name="locale" id="locale">
        <option value="en">en</option>
        <option value="vi">vi</option>
    </select>
    <button type="submit"><%= Lang.getKey(language, "Ok")%></button>
</form>
<script src="js/language.js"></script>

