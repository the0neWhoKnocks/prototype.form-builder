<select-item>
  <select>
    <!-- 
      account for optgroup
      <optgroup label="">
        <option value="{{value}}">{{label}}</option>
      </optgroup>
    --> 
    <option each={ opts.options } value="{ value }">{ label }</option>
  </select>
</select-item>