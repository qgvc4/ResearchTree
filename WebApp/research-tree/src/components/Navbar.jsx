import React, { Component } from 'react'
import { Link } from 'react-router-dom';

// import {connect} from 'react-redux'

//antd
import { Layout, Menu, Icon } from 'antd';

//c1e791 green


const { Sider, } = Layout;

class NavbarFeed extends Component {

  render() {
    const {pageNum} = this.props;

    return (
      <Layout>
        <Sider style={{
          overflow: 'auto', height: '100%', position: 'fixed', left: 0,
          background: '#74997a'
        }}
        >
          <div className="logo" />

          <Menu theme="" mode="inline" defaultSelectedKeys={pageNum} style={{ background: '#74997a', color: 'white' }} onClick={this.handleClick}>
            <Menu.Item key="1">
              <Link to={'/Feed'}>
                <Icon type="user" />
                <span className="nav-text">Feed</span>
              </Link>
            </Menu.Item>
            <Menu.Item key="2">
              <Link to={'/People'}>
                <Icon type="team" />
                <span className="nav-text">People</span>
              </Link>
            </Menu.Item>
            <Menu.Item key="3">
              <Link to={'/Job'}>
                <Icon type="shop" />
                <span className="nav-text">Job</span>
              </Link>
            </Menu.Item>
            <Menu.Item key="4">
              <Link to={'/Profile'}>
                <Icon type="bar-chart" />
                <span className="nav-text">Profile</span>
              </Link>
            </Menu.Item>
          </Menu>
        </Sider>
      </Layout>
    );
  }
}



export default (NavbarFeed);
