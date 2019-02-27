import React, { Component } from 'react'
import { Form, Icon, Input, Button, Alert } from 'antd'
import '../style/login.css'

import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { login } from '../actions/AccountAction';


class Login extends Component {
  handleSubmit = (e) => {
    e.preventDefault();
    this.props.form.validateFields((err, values) => {
      if (!err) {
        this.props.login(values);
        if (this.props.error != null) {
          this.props.history.push('/Feed');
        }
      }
    });
  }

  render() {
    const { getFieldDecorator } = this.props.form;

    let error;
    if (this.props.error != null) {
      error = <Alert message={this.props.error} type="error" />
    }

    return (
      <div>
        <Form onSubmit={this.handleSubmit} className="login-form">
          <Form.Item>
            {getFieldDecorator('Email', {
              rules: [{ required: true, message: 'Please input your email!' }],
            })(
              <Input prefix={<Icon type="user" style={{ color: 'rgba(0,0,0,.25)' }} />} placeholder="Email" />
            )}
          </Form.Item>
          <Form.Item>
            {getFieldDecorator('Password', {
              rules: [{ required: true, message: 'Please input your Password!' }],
            })(
              <Input prefix={<Icon type="lock" style={{ color: 'rgba(0,0,0,.25)' }} />} type="password" placeholder="Password" />
            )}
          </Form.Item>
          <Form.Item>          
            <Button type="primary" htmlType="submit" className="login-form-button">
              Log in
            </Button>
            <br/>
            Or <a href="/Signup">Sign Up now!</a>
          </Form.Item>
        </Form>
        {error}
      </div>
    );
  }
}

Login.propTypes = {
  login: PropTypes.func.isRequired
};

const mapStateToProps = state => ({
  user: state.user.user,
  error: state.user.error
})

const LoginForm = Form.create({ name: 'normal_login' })(Login);

export default connect(mapStateToProps, { login })(LoginForm);