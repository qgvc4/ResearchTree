import React from 'react';
import ReactDOM from 'react-dom';
// import 'antd/dist/antd.css';
import { Card } from 'antd';

ReactDOM.render(
  <div>
    <Card
      title="Title"
      extra={<a href="#">More</a>}
      style={{ width: 400 }}
    >
      
      <p>Card Content/Post Description</p>
    </Card>
  </div>,
  document.getElementById('container')
);
        