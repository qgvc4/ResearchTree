import React, { Component } from 'react'
import {
  Form,
  Input,
  Button,
  Select,
} from 'antd';
import ImageUploader from 'react-images-upload';

import {Majors} from '../../declaration/major';
import {Standings} from '../../declaration/standing';

import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { signup, clearError } from '../../actions/AccountAction';

const { Option } = Select;

class Signup extends Component {
  state = {
    confirmDirty: false,
    image: null
  };

  handleSubmit = (e) => {
    e.preventDefault();
    this.props.form.validateFieldsAndScroll((err, values) => {
      if (!err) {
        values["Role"] = values && values.Standing === 2 ? 0 : 1;
        delete values["confirm"];

        if (values["image"]) {
          new Promise((resolve, reject) => {
            var reader = new FileReader();
            reader.addEventListener("load", () => {
                var data = reader.result;
                var res = data.split(",");
                var imageData = res[1];
                resolve(imageData);
            });
            reader.readAsDataURL(values["image"]);
          }).then(imageData => {
            values["image"] = imageData;
            this.props.clearError();
            this.props.signup(values);
          });
        } else {
          this.props.clearError();
          this.props.signup(values);
        }
      }
    });
  }

  handleConfirmBlur = (e) => {
    const value = e.target.value;
    this.setState({ confirmDirty: this.state.confirmDirty || !!value });
  }

  compareToFirstPassword = (rule, value, callback) => {
    const form = this.props.form;
    if (value && value !== form.getFieldValue('Password')) {
      callback('Two passwords that you enter is inconsistent!');
    } else {
      callback();
    }
  }

  validateToNextPassword = (rule, value, callback) => {
    const form = this.props.form;
    const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/
    if (!pattern.test(value)) {
      callback('Password must be more than 6 characters, with at least one capital, numeric or special character')
      return;
    }
    if (value && this.state.confirmDirty) {
      form.validateFields(['confirm'], { force: true });
    }
    callback();
  }

  validateLocationZipCode = (rule, value, callback) => {
    const pattern = /^(\d{5})?$/
    if (!pattern.test(value)) {
      callback('Not a valid ZipCode, must be 5 digits')
    } else {
      callback()
    }
  }

  validateMajorsMaxLimit = (rule, value, callback) => {
    if (value.length > 3) {
      callback('Max 3 Majors')
    } else {
      callback()
    }
  }

  normFile = (e) => {
    if (Array.isArray(e) && e.length > 0) {
      return e[0];
    }
    return null;
  }

  render() {
    if (this.props.error == null && this.props.user.token != null) {
      this.props.history.push('/Feed');
    }

    const { getFieldDecorator } = this.props.form;

    const formItemLayout = {
      labelCol: {
        xs: { span: 24 },
        sm: { span: 8 },
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 16 },
      },
    };
    const tailFormItemLayout = {
      wrapperCol: {
        xs: {
          span: 24,
          offset: 0,
        },
        sm: {
          span: 16,
          offset: 8,
        },
      },
    };

    return (
      <div>
        <Form onSubmit={this.handleSubmit} style={{width: "80%"}}>
          <Form.Item
            {...formItemLayout}
            label="Email"
          >
            {getFieldDecorator('Email', {
              rules: [{
                type: 'email', message: 'The input is not valid E-mail!',
              }, {
                required: true, message: 'Please input your E-mail!',
              }],
            })(
              <Input />
            )}
          </Form.Item>
          <Form.Item
            {...formItemLayout}
            label="Password"
          >
            {getFieldDecorator('Password', {
              rules: [{
                required: true, message: 'Please input your password!',
              }, {
                validator: this.validateToNextPassword,
              }],
            })(
              <Input type="password" />
            )}
          </Form.Item>
          <Form.Item
            {...formItemLayout}
            label="Confirm Password"
          >
            {getFieldDecorator('confirm', {
              rules: [{
                required: true, message: 'Please confirm your password!',
              }, {
                validator: this.compareToFirstPassword,
              }],
            })(
              <Input type="password" onBlur={this.handleConfirmBlur} />
            )}
          </Form.Item>
          <Form.Item
            {...formItemLayout}
            label="FirstName"
          >
            {getFieldDecorator('FirstName', {
              rules: [{ required: true, message: 'Please input your firstname!', whitespace: true }],
            })(
              <Input />
            )}
          </Form.Item>
          <Form.Item
            {...formItemLayout}
            label="LastName"
          >
            {getFieldDecorator('LastName', {
              rules: [{ required: true, message: 'Please input your lastname!', whitespace: true }],
            })(
              <Input />
            )}
          </Form.Item>
          <Form.Item
            {...formItemLayout}
            label="Standing"
            hasFeedback
          >
            {getFieldDecorator('Standing', {
              rules: [
                { required: true, message: 'Please select your standing!' },
              ],
            })(
              standingOptions()
            )}
          </Form.Item>
          <Form.Item
            {...formItemLayout}
            label="Majors"
          >
            {getFieldDecorator('Majors', {
              rules: [
                { required: true, message: 'Please select your majors!', type: 'array' },
                { validator: this.validateMajorsMaxLimit }
              ],
            })(
              majorOptions()
            )}
          </Form.Item>
          <Form.Item
            {...formItemLayout}
            label="Location"
          >
            {getFieldDecorator('Location', {
              rules: [
                { required: true, message: 'Please input your location!', whitespace: true },
                { validator: this.validateLocationZipCode }
              ],
            })(
              <Input placeholder="ZipCode"/>
            )}
          </Form.Item>
          <Form.Item
            {...formItemLayout}
            label="Profile"
          >
            {getFieldDecorator('image', {
              valuePropName: 'fileList',
              getValueFromEvent: this.normFile,
            })(
              <ImageUploader
                withIcon={true}
                withLabel={true}
                label='JPG|Size<1MB'
                buttonText='Upload Profile'
                onChange={this.onDrop}
                imgExtension={['.jpg']}
                maxFileSize={1048576}
                withPreview={true}
            />
            )}
          </Form.Item>
          <Form.Item {...tailFormItemLayout}>
            <Button type="primary" htmlType="submit">Sign Up</Button>
          </Form.Item>
        </Form>
      </div>
      
    );
  }
}

function majorOptions() {
  var majors = [];
  for (var i = 0; i < Majors.length; i++) {
    majors.push(<Option key={i} value={i}>{Majors[i]}</Option>)
  }
  return (
    <Select mode="multiple" placeholder="Please select majors">
      {majors}
    </Select>
  );
}

function standingOptions() {
  var standings = [];
  for (var i = 0; i < Standings.length; i++) {
    standings.push(<Option key={i} value={i}>{Standings[i]}</Option>)
  }
  return (
    <Select placeholder="Please select your standing">
      {standings}
    </Select>
  );
}

Signup.propTypes = {
  signup: PropTypes.func.isRequired
};

const mapStateToProps = state => ({
  user: state.user.user,
  error: state.user.error
})

const WrappedRegistrationForm = Form.create({ name: 'register' })(Signup);

export default connect(mapStateToProps, { signup, clearError })(WrappedRegistrationForm);
