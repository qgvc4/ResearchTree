import React, { Component } from 'react'
import {Redirect} from 'react-router-dom';
import { Layout, Form, Icon, Input, Button, Alert } from 'antd'
import '../../style/Account/login.css'

import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { login, clearError } from '../../actions/AccountAction';

const { Content } = Layout;

class Login extends Component {
  handleSubmit = (e) => {
    e.preventDefault();
    this.props.form.validateFields((err, values) => {
      if (!err) {
        this.props.clearError();
        this.props.login(values);
      }
    });
  }

  render() {
    if (this.props.error == null && this.props.user.token != null) {
      return <Redirect to='/Feed'></Redirect>
    }
    const { getFieldDecorator } = this.props.form;

    let error;
    if (this.props.error != null) {
      error = <Alert message={this.props.error} type="error" />
    }

    return (
      <Layout className="layout" style={{background: '#fff'}}>
        <Content style={{ padding: '0 25%' }}>
          <div className="login-container" style={{ padding: 24, background: '#fff', textAlign: 'center' }}>
            <h1 style={{color: '#c1e791'}}>ResearchTree</h1>
            <div className="login_tree"></div>
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
        </Content>
      </Layout>
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

export default connect(mapStateToProps, { login, clearError })(LoginForm);