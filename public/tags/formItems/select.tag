<selectItem>
  <select>
    <!-- 
      account for optgroup
      <optgroup label="">
        <option value="{{value}}">{{label}}</option>
      </optgroup>
    --> 
    <option each={{options}} value="{{value}}">{{label}}</option>
  </select>
</selectItem>